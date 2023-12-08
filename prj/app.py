from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, AjtGroupeForm, AjtSeanceForm, AjtFactureForm, AjtFormationForm, LoginForm, AjtProf, Ajtcours, Selectgrp, AjtFacture
from flask_mysqldb import MySQL
from ast import literal_eval

app = Flask(__name__)
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_HOST'] = '127.0.0.1' # localht
app.config['MYSQL_DB'] = 'mydb'

app.config['SECRET_KEY'] = 'WlUrPgXjHOL9OquLGcQ96yfoZOyNLfCYFV05NUQN9DE3Fb4tUcWW02s4pYySzeDj'

mysql = MySQL(app)

@app.route('/index')
def index():
    return render_template('index.html')


@app.route('/search_eleves', methods=['GET'])
def search_eleves():
    query = request.args.get('query', '').strip()

    if query:
        cur = mysql.connection.cursor()
        search_query = "SELECT * FROM eleve WHERE nom_ev LIKE %s OR prenom_ev LIKE %s"
        cur.execute(search_query, ('%' + query + '%', '%' + query + '%'))
        eleves_data = cur.fetchall()
        cur.close()
    else:
        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM eleve')
        eleves_data = cur.fetchall()
        cur.close()

    return render_template("eleves.html", eleves_data=eleves_data)

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
            session['username'] = username
            return render_template('index.html',username=username)
        else:
            flash('Username ou Password invalide.', 'error')
            return render_template('login.html', form=form)

    return render_template('login.html', form=form)


@app.route('/logout')
def logout():
    session.pop('username', None)  # Remove username from session
    return redirect(url_for('login'))

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

    # Fetch courses from the database and populate choices
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM formation")
    formations = cur.fetchall()
    cur.close()

    # Update the choices for the cours field
    form.formation.choices = [(formation[0], formation[1]) for formation in formations]

    if form.validate_on_submit():
        # Retrieve form data
        nom_ev = form.nom_ev.data
        prenom_ev = form.prenom_ev.data
        email_ev = form.email_ev.data
        phone_ev = form.numtel_ev.data
        numtel_par = form.numtel_par.data
        date_inscrit = form.date_inscrit.data
        test = form.test.data

        # SQL query to insert data into the Eleve table
        insert_query = """
        INSERT INTO Eleve (nom_ev, prenom_ev, email_ev, phone_ev, numtel_par, date_inscrit, test)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """
        cur = mysql.connection.cursor()

        # Execute the query with the form data
        cur.execute(insert_query, (nom_ev, prenom_ev, email_ev, phone_ev, numtel_par, date_inscrit, test))
        mysql.connection.commit()
        ideleve = cur.lastrowid

        idformation = form.formation.data
        

        cur.close()
        flash('Ajout avec succès! ideleve={}, idformation={}'.format(ideleve, idformation), 'success')

        return  redirect(url_for('ajouter_cours', ideleve=ideleve, idformation=idformation))

    return render_template('ajouter_eleve.html', form=form)


@app.route('/ajouter_cours', methods=['POST', 'GET'])
def ajouter_cours():
    ideleve = request.args.get('ideleve')
    idformation = request.args.get('idformation')
    
    

    form = Ajtcours()
    cur = mysql.connection.cursor()
    cur.execute("SELECT * from cours where formation_idformation = %s ", (idformation,))
    courses = cur.fetchall()
    cur.close()

    form.cours.choices = [(cours[0], cours[1]) for cours in courses]
    minf = min_formation(idformation)
    form.nb_seances.validators[0].min = minf
    form.nb_seances.validators[0].message = f"{minf} seances au minimum "

    if form.validate_on_submit():
        idcours = form.cours.data
        
        cur = mysql.connection.cursor()
        # cur.execute("SELECT test from eleve where ideleve = %s", (ideleve,))
        # test = cur.fetchone()
        # cur.close()
        
        


        # Do something with idcours if needed
        group_disp = groupe_disponible(idcours)
        if not group_disp:
            flash("Tous les groupes sont remplis", "error")
            return redirect(url_for('index'))
        nb_seances = form.nb_seances.data

        flash('Cours ajouté avec succès! grp = {} et idcours = {} '.format(group_disp, idcours), 'success')
        return redirect(url_for('affectation', idcours = idcours, ideleve = ideleve, idformation = idformation, nb_seances = nb_seances))

    return render_template('ajouter_cours.html', ideleve=ideleve, form=form, idformation=idformation)


def min_formation(idformation):
    if idformation == 2:
        return 8
    else:
        return 2



@app.route('/affectation', methods=['GET', 'POST'])
def affectation():
    form = Selectgrp()
    
    
    ideleve = request.args.get('ideleve')
    idformation = request.args.get('idformation')
    idcours = request.args.get('idcours')
    group_disp = groupe_disponible(idcours)
    nb_seances = request.args.get('nb_seances')
    somme = int(nb_seances)*150
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM eleve_has_cours where nb_achete is null")
    mysql.connection.commit()
    cur.close()
    
    
    
    flash('nb seance = {} et type = {} somme = {}'.format(nb_seances, type(nb_seances), somme), 'success')

    if request.method == 'POST':
        group_voulu = request.form.getlist('group_voulu[]')
        cur = mysql.connection.cursor()
        cur.execute("UPDATE groupe SET nombre_eleves = nombre_eleves + 1 where idgroupe in %s ", (group_voulu,))
        for g in group_voulu:
            cur.execute("INSERT INTO eleve_has_groupe (ideleve, idgroupe) values (%s, %s)", (ideleve, g) )
        cur.execute("INSERT INTO facture (somme_total, date_paiement, eleve) VALUES (%s, CURDATE(), %s)", (somme, ideleve))
        cur.execute("INSERT INTO eleve_has_cours (ideleve, idcours, nb_achete) values (%s, %s, %s)", (ideleve, idcours, nb_seances))
        mysql.connection.commit()
        cur.close()
        flash("Facture ajouté avec success", 'success')
        return redirect(url_for('index'))
    
    return render_template('affectation.html', ideleve=ideleve, form=form, idformation=idformation, idcours = idcours, group_disp = group_disp, nb_seances = nb_seances )




    

    
    




def groupe_disponible(cours):
    cur = mysql.connection.cursor()
    cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s ", (cours,) )
    groups = cur.fetchall()
    cur.close()
    return groups


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
if __name__ == "__main__":
    app.run(debug=True)
