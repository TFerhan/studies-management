from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, AjtProf, LoginForm,AjtFactureForm,AjtFormationForm,AjtGroupeForm,AjtSeanceForm
from flask_mysqldb import MySQL



app = Flask(__name__)
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_HOST'] = '127.0.0.1' # localht
app.config['MYSQL_DB'] = 'mydb'

app.config['SECRET_KEY'] = 'WlUrPgXjHOL9OquLGcQ96yfoZOyNLfCYFV05NUQN9DE3Fb4tUcWW02s4pYySzeDj'

mysql = MySQL(app)
@app.route('/home')
def home():
    return render_template('index.html')
@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm() 

    if form.validate_on_submit():
        username = form.username.data
        password = form.password.data
        cursor = mysql.connection.cursor()
        
        select_admin = """SELECT * FROM admins WHERE username = %s AND password = %s"""
        cursor.execute(select_admin, (username, password))
        admin_data = cursor.fetchall() 

        if admin_data:
            return render_template('index.html',username=username)
        else:
            return 'Invalid username or password. Please try again.'

    return render_template('login.html', form=form)




@app.route('/professeur')
def profs_list():
    cursor = mysql.connection.cursor()
    select_prof=""" SELECT * FROM enseignant; """
    cursor.execute(select_prof)
    professeurs= cursor.fetchall()  
    return render_template('profs.html', professeurs=professeurs)

@app.route('/ajouter_prof', methods=['GET', 'POST'])
def ajouter_prof():
    form = AjtProf()

    if form.validate_on_submit():
        # Retrieve form data
        Cin_prof = form.Cin_prof.data
        nom_prof = form.nom_prof.data
        prenom_prof = form.prenom_prof.data
        email_prof = form.email_prof.data
        numtel_prof = form.numtel_prof.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO enseignant (Cin_prof, nom_enseignant, prenom_enseignant, email_enseignant, numtel_enseignant)
        VALUES (%s, %s, %s, %s, %s)
        """

        # Execute the query with the form data
        cursor = mysql.connection.cursor()
        cursor.execute(insert_query, (Cin_prof, nom_prof, prenom_prof, email_prof, numtel_prof))
        mysql.connection.commit()
        flash('Ajout avec succès!', 'success')

        return render_template('ajouter_prof.html', message = "Ajouter avec success",form=form)

    return render_template('ajouter_prof.html', form=form)

@app.route('/delete_prof/<int:idenseignant>', methods=['POST'])
def delete_prof(idenseignant):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM enseignant WHERE idenseignant = %s', (idenseignant,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('profs_list')) 

from flask import redirect, url_for

@app.route('/modifier_prof/<int:idenseignant>', methods=['GET', 'POST'])
def modifier_prof(idenseignant):
    cursor = mysql.connection.cursor()
    select_query = "SELECT * FROM enseignant WHERE idenseignant = %s"
    cursor.execute(select_query, (idenseignant,))
    professeur = cursor.fetchone()
    cursor.close()

    form = AjtProf()

    if form.validate_on_submit():
        Cin_prof = form.Cin_prof.data
        nom_prof = form.nom_prof.data
        prenom_prof = form.prenom_prof.data
        email_prof = form.email_prof.data
        numtel_prof = form.numtel_prof.data

        update_query = """
        UPDATE enseignant
        SET Cin_prof = %s, nom_enseignant = %s, prenom_enseignant = %s,
            email_enseignant = %s, numtel_enseignant = %s
        WHERE idenseignant = %s
        """
        
        cursor = mysql.connection.cursor()

        try:
            cursor.execute(update_query, (Cin_prof, nom_prof, prenom_prof, email_prof, numtel_prof, idenseignant))
            mysql.connection.commit()

            flash('Modification réussie!', 'success')
            return redirect(url_for('profs_list'))  # Redirige vers la liste des professeurs

        except Exception as e:
            flash('Erreur lors de la modification!', 'error')

        finally:
            cursor.close()

    return render_template('modifier_prof.html', prof=professeur, form=form)

        
    



@app.route("/eleves")
def eleves():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM eleve')
    eleves_data = cur.fetchall()
    cur.close()
    return render_template("eleves.html", eleves_data = eleves_data)

@app.route('/ajouter_eleve', methods=['GET', 'POST'])
def ajouter_eleve():
    form = AjtEleveForm()

    if form.validate_on_submit():
        # Retrieve form data
        nom_ev = form.nom_ev.data
        prenom_ev = form.prenom_ev.data
        email_ev = form.email_ev.data
        phone_ev = form.numtel_ev.data
        numtel_par = form.numtel_par.data
        date_inscrit = form.date_inscrit.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO Eleve (nom_ev, prenom_ev, email_ev, phone_ev, numtel_par, date_inscrit)
        VALUES (%s, %s, %s, %s, %s, %s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (nom_ev, prenom_ev, email_ev, phone_ev, numtel_par, date_inscrit))
        mysql.connection.commit()
        cur.close()
        flash('Ajout avec succès!', 'success')

        return redirect(url_for('eleves'))
    return render_template('ajouter_eleve.html', form=form)


@app.route('/delete_eleve/<int:id_eleve>', methods=['POST'])
def delete_eleve(id_eleve):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM eleve WHERE id_eleve = %s', (id_eleve,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('eleves'))

@app.route('/groupes')
def groupes():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM groupe')
    groupe_data = cur.fetchall()
    cur.close()
    return render_template("groupes.html", groupe_data = groupe_data)


@app.route('/ajouter_groupe', methods=['GET', 'POST'])
def ajouter_groupe():
    form = AjtGroupeForm()

    if form.validate_on_submit():
        # Retrieve form data
        nombre_eleves = form.nombre_eleves.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO groupe (nombre_eleves)
        VALUES (%s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (nombre_eleves,))
        mysql.connection.commit()
        cur.close()
        flash('Ajout avec succès!', 'success')

        return redirect(url_for('groupes'))  # Assuming you have a route named 'groupes'
    return render_template('ajouter_groupe.html', form=form)

@app.route('/delete_groupe/<int:idgroupe>', methods=['POST'])
def delete_groupe(idgroupe):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM groupe WHERE idgroupe = %s', (idgroupe,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('groupes')) 

@app.route('/ajouter_seance', methods=['GET', 'POST'])
def ajouter_seance():
    form = AjtSeanceForm()

    if form.validate_on_submit():
        # Retrieve form data
        type_séance = form.type_seance.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO séance (type_séance)
        VALUES (%s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (type_séance,))
        mysql.connection.commit()
        cur.close()
        flash('Ajout avec succès!', 'success')

        return redirect(url_for('seances'))  # Assuming you have a route named 'seances'
    return render_template('ajouter_seance.html', form=form)


@app.route('/delete_seance/<int:idseance>', methods=['POST'])
def delete_seance(idseance):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM séance WHERE idséance = %s', (idseance,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('seances'))


@app.route('/seances')
def seances():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM séance')
    seances_data = cur.fetchall()
    cur.close()
    return render_template("seances.html", seances_data=seances_data)


@app.route('/ajouter_facture', methods=['GET', 'POST'])
def ajouter_facture():
    form = AjtFactureForm()

    if form.validate_on_submit():
        # Retrieve form data
        somme_total = form.somme_total.data
        date_paiement = form.date_paiement.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO facture (somme_total, date_paiement)
        VALUES (%s, %s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (somme_total, date_paiement))
        mysql.connection.commit()
        cur.close()
        flash('Ajout avec succès!', 'success')

        return redirect(url_for('factures'))  # Assuming you have a route named 'factures'
    return render_template('ajouter_facture.html', form=form)

@app.route('/factures')
def factures():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM facture')
    factures_data = cur.fetchall()
    cur.close()
    return render_template("factures.html", factures_data=factures_data)

@app.route('/delete_facture/<int:id_facture>', methods=['POST'])
def delete_facture(id_facture):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM facture WHERE idfacture = %s', (id_facture,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('factures'))


@app.route('/ajouter_formation', methods=['GET', 'POST'])
def ajouter_formation():
    form = AjtFormationForm()

    if form.validate_on_submit():
        # Retrieve form data
        nom_formation = form.nom_formation.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO formation (nom_formation)
        VALUES (%s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (nom_formation,))
        mysql.connection.commit()
        cur.close()
        flash('Ajout avec succès!', 'success')

        return redirect(url_for('formations')) 
    return render_template('ajouter_formation.html', form=form)


@app.route('/delete_formation/<int:id_formation>', methods=['POST'])
def delete_formation(id_formation):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM formation WHERE idformation = %s', (id_formation,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('formations'))


@app.route('/formations')
def formations():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM formation')
    formations_data = cur.fetchall()
    cur.close()
    return render_template("formations.html", formations_data=formations_data)

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
