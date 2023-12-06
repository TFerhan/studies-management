from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, AjtGroupeForm, AjtSeanceForm, AjtFactureForm, AjtFormationForm, LoginForm, AjtProf, Ajtcours, Ajtseance
from flask_mysqldb import MySQL



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

        selected_formation = form.formation.data
        idformation = selected_formation[0]

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

    if form.validate_on_submit():
        selected_cours = form.cours.data
        idcours = selected_cours[0]

        # Do something with idcours if needed
        group_disp = groupe_disponible(idcours)
        if not group_disp:
            flash("Tous les groupes sont remplis", "error")
            return redirect(url_for('index'))

        flash('Cours ajouté avec succès!', 'success')
        return redirect(url_for('affectation', idcours = idcours, ideleve = ideleve, idformation = idformation, group_disp = group_disp))

    return render_template('ajouter_cours.html', ideleve=ideleve, form=form, idformation=idformation)

@app.route('/affectation', methods=['GET', 'POST'])
def affectation():
    ideleve = request.args.get('ideleve')
    idformation = request.args.get('idformation')
    idcours = request.args.get('idcours')
    group_disp = request.args.get('group_disp')
    cur = mysql.connection.cursor()
    cur.execute("SELECT test from eleve where ideleve = %s", (ideleve,))
    test = cur.fetchone()
    cur.close()
    
    




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

@app.route('/gerer_abs_groupe/<int:idgroupe>', methods=['GET', 'POST']) 
def gerer_abs_groupe(idgroupe):
        
        cur = mysql.connection.cursor()
        cur.execute(''' 
            SELECT e.id_eleve, e.prenom_ev, e.nom_ev
            FROM eleve e
            INNER JOIN eleve_has_groupe eg ON e.id_eleve = eg.ideleve
            WHERE eg.idgroupe = %s
        ''', (idgroupe,))
        eleves_groupe = cur.fetchall()
        cur.execute('SELECT idséance FROM séance WHERE idgroupe = %s',(idgroupe,))
        idseance=cur.fetchone()
        cur.execute('SELECT nb_abscence FROM eleve_has_seance WHERE ideleve IN (SELECT ideleve FROM eleve_has_groupe WHERE idgroupe = %s) AND idseance = %s', (idgroupe,idseance,))
        nbs=cur.fetchall()
        cur.execute('SELECT idcours FROM séance WHERE idséance=%s',(idseance,))
        idcours=cur.fetchone()
        cur.execute('SELECT nb_seances_rest FROM eleve_has_cours WHERE idcours=%s AND ideleve IN (SELECT ideleve FROM eleve_has_groupe WHERE idgroupe = %s)',(idcours,idgroupe,))
        nombre_seances_rest=cur.fetchall()
        cur.close()

        return render_template('gerer_abs.html', eleves_groupe=eleves_groupe, idgroupe=idgroupe,nbs=nbs,nombre_seances_rest=nombre_seances_rest)
@app.route('/valider_absences/<int:idgroupe>', methods=['POST'])
def valider_absences(idgroupe):
    if request.method == 'POST':
        eleves_absents_ids = request.form.getlist('eleves_absents[]')
        cur = mysql.connection.cursor()

        cur.execute('SELECT idséance FROM séance WHERE idgroupe = %s', (idgroupe,))
        idseance = cur.fetchone()[0]

        # Récupérer tous les élèves du groupe
        cur.execute('SELECT ideleve FROM eleve_has_groupe WHERE idgroupe = %s', (idgroupe,))
        eleves_du_groupe = cur.fetchall()
        eleves_du_groupe_ids = [eleve[0] for eleve in eleves_du_groupe]

        for ideleve in eleves_du_groupe_ids:
            if str(ideleve) not in eleves_absents_ids:
                # Mettre à jour nb_seances_rest pour les étudiants présents non absents
                cur.execute('''UPDATE eleve_has_cours
                               SET nb_seances_rest = nb_seances_rest - 1
                               WHERE ideleve = %s AND idcours IN
                                   (SELECT idcours FROM séance WHERE idséance = %s)''', (ideleve, idseance))
                mysql.connection.commit()

        for ideleve in eleves_absents_ids:
            # Incrémenter le nb_abscences des élèves absents
            cur.execute('''UPDATE eleve_has_seance
                           SET nb_abscence = nb_abscence + 1
                           WHERE ideleve = %s AND idseance = %s''', (ideleve, idseance))
            mysql.connection.commit()

            # Vérifier si le nombre d'absences est supérieur ou égal à 2
            cur.execute('''SELECT nb_abscence FROM eleve_has_seance
                           WHERE ideleve = %s AND idseance = %s''', (ideleve, idseance))
            nb_abscence = cur.fetchone()[0]

            if nb_abscence >= 2:
                # Mettre à jour nb_seances_rest si nb_abscence >= 2
                cur.execute('''UPDATE eleve_has_cours
                               SET nb_seances_rest = nb_seances_rest - 1
                               WHERE ideleve = %s AND idcours IN
                                   (SELECT idcours FROM séance WHERE idséance = %s)''', (ideleve, idseance))
                mysql.connection.commit()        

        cur.close()
        flash('Les absences ont été enregistrées avec succès!', 'success')
        return redirect(url_for('gerer_abs_groupe', idgroupe=idgroupe))


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

