from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, Achtcours, LoginForm, MDPOUB, Ajtcours, Selectgrp, AchtSeanceForm
from flask_mysqldb import MySQL
from ast import literal_eval

app = Flask(__name__)
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_HOST'] = '127.0.0.1' # localht
app.config['MYSQL_DB'] = 'mydb'

app.config['SECRET_KEY'] = 'WlUrPgXjHOL9OquLGcQ96yfoZOyNLfCYFV05NUQN9DE3Fb4tUcWW02s4pYySzeDj'

mysql = MySQL(app)
def require_login(route_function):
    def wrapper(*args, **kwargs):
        if 'username' not in session:
            flash('Veuillez vous connecter d\'abord.', 'error')
            return redirect(url_for('login'))
        return route_function(*args, **kwargs)
    
    wrapper.__name__ = route_function.__name__
    wrapper.__doc__ = route_function.__doc__
    return wrapper

@app.route('/index')
@require_login
def index():
    return render_template('index.html')


@app.route('/mdp_oublie', methods=['GET', 'POST'])
def mdp_oublie():
    form = MDPOUB()

    if form.validate_on_submit():
        cin = form.cin.data
        cur = mysql.connection.cursor()
        cur.execute('Select id_admin from admins where CIN = %s', (cin,))
        p = cur.fetchone()
        if not p:
            flash('Aucun CIN de cette valeur. Veuillez contacter votre administrateur', 'error')
            return redirect(url_for('mdp_oublie'))
        nv_mdp = form.nv_mdp.data
        verf_mdp = form.verf_mdp.data
        if nv_mdp != verf_mdp:
            flash('Veuillez entrer les memes mots de passe')
            return redirect(url_for('mdp_oublie'))
        cur.execute('UPDATE admins set password = %s where id_admin = %s', (nv_mdp, p[0]))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('login'))
    return render_template('mdp_oublie.html', form = form)
        


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
@require_login
def eleves():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM eleve')
    eleves_data = cur.fetchall()
    cur.close()
    return render_template("eleves.html", eleves_data = eleves_data)




@app.route('/ajouter_eleve', methods=['GET', 'POST'])
@require_login
def ajouter_eleve():
    ideleve = request.args.get('ideleve')
    c = request.args.get('c')
    c = int(c)
    

    # Fetch courses from the database and populate choices
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM formation")
    formations = cur.fetchall()
    cur.close()

    
    

    if c == 1:
            form = Achtcours()
            form.formation.choices = [(formation[0], formation[1]) for formation in formations]
            if form.validate_on_submit():
                cur = mysql.connection.cursor()
                cur.execute('UPDATE eleve set test = 0 where id_eleve = %s ', (ideleve,))
                mysql.connection.commit()
                cur.close()
                idformation = form.formation.data
                print(ideleve)
                return  redirect(url_for('ajouter_cours', ideleve=ideleve, idformation=idformation, p = 0))







    if c == 0:
            form = AjtEleveForm()
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
                flash('Ajout avec succès! ', 'success')

                return  redirect(url_for('ajouter_cours', ideleve=ideleve, idformation=idformation, p = 0))

    return render_template('ajouter_eleve.html', form=form, c = c, ideleve = ideleve)


@app.route('/ajouter_cours', methods=['POST', 'GET'])
@require_login
def ajouter_cours():
    ideleve = request.args.get('ideleve')
    idformation = request.args.get('idformation')
    idcours = request.args.get('idcours')
    
    p = request.args.get('p')
    p = int(p)
    
    if p == 1:
        
        form = AchtSeanceForm()
        if form.validate_on_submit():
            nbseance = form.nb_seances_ach.data
            print(form.nb_seances_ach.data)
            print(idcours)
            cur = mysql.connection.cursor()
            cur.execute("UPDATE eleve_has_cours SET nb_achete = nb_achete + %s, nb_rest = nb_rest + %s WHERE idcours = %s AND ideleve = %s", (nbseance, nbseance, idcours, ideleve))
            cur.execute("INSERT INTO facture (somme_total, date_paiement, eleve) VALUES (%s, CURDATE(), %s)", (150*nbseance, ideleve))
            mysql.connection.commit()
            cur.close()
            flash('Facture ajoutée', 'success')
            return redirect(url_for('index'))


    
    
    
    if p == 0:
        idformation = request.args.get('idformation')
        form = Ajtcours()
        cur = mysql.connection.cursor()
        cur.execute("SELECT * from cours where formation_idformation = %s ", (idformation,))
        courses = cur.fetchall()
        cur.close()

        form.cours.choices = [(cours[0], cours[1]) for cours in courses]
        form.nb_seances.data = min_formation(idformation)
        form.nb_seances.validators[0].min = min_formation(idformation)
        form.nb_seances.validators[0].message = f"{min_formation(idformation)} seances au minimum "

        if form.validate_on_submit():
            idcours = form.cours.data
            
            cur = mysql.connection.cursor()
            cur.execute("SELECT test from eleve where id_eleve = %s", (ideleve,))
            test = cur.fetchone()[0]
            cur.close()
            print(test)
            if test:
                cur = mysql.connection.cursor()
                cur.execute("INSERT INTO eleve_has_cours (ideleve, idcours, nb_achete) values (%s, %s, 0)", (ideleve, idcours,))
                cur.execute("INSERT INTO facture (somme_total, date_paiement, eleve) VALUES (%s, CURDATE(), %s)", (150, ideleve))
                mysql.connection.commit()
                flash("Facture ajoutée avec success!", 'success')
                return redirect(url_for('index'))

            
            


            # Do something with idcours if needed
            group_disp = groupe_disponible(idcours)
            if not group_disp:
                flash("Aucun groupe disponible", "error")
                return redirect(url_for('index'))
            nb_seances = form.nb_seances.data

            return redirect(url_for('affectation', idcours = idcours, ideleve = ideleve, nb_seances = nb_seances, p = p))

    return render_template('ajouter_cours.html', ideleve=ideleve, form=form, idformation=idformation,   p = p, idcours= idcours )


def min_formation(idformation):
    if int(idformation) == 2:
        return 8
    else:
        return 2



@app.route('/affectation', methods=['GET', 'POST'])
@require_login
def affectation():
    form = Selectgrp()
    p = request.args.get('p')
    p = int(p)
    
    
    ideleve = request.args.get('ideleve')
    idcours = request.args.get('idcours')
    group_disp = seance_disponible(idcours, ideleve)
    nb_seances = request.args.get('nb_seances')
    somme = int(nb_seances)*150
    cur = mysql.connection.cursor()
    cur.execute("DELETE FROM eleve_has_cours where nb_achete is null")
    mysql.connection.commit()
    cur.close()
    

    if request.method == 'POST':
        group_voulu = request.form.getlist('group_voulu[]')
        cur = mysql.connection.cursor()
        if not group_voulu:
            flash('Aucun groupe disponible', 'error')
            return redirect(url_for('index'))
        cur.execute("SELECT idséance from séance where idgroupe in %s", (group_voulu,))
        séances_id = cur.fetchall()
        cur.execute("UPDATE groupe SET nombre_eleves = nombre_eleves + 1 where idgroupe in %s ", (group_voulu,))
        for g in group_voulu:
            cur.execute("INSERT INTO eleve_has_groupe (ideleve, idgroupe) values (%s, %s)", (ideleve, g) )
        for s in séances_id:
            cur.execute("INSERT INTO eleve_has_seance (ideleve, idseance, abscence) values (%s, %s, 0)", (ideleve, s,))
        cur.execute("INSERT INTO facture (somme_total, date_paiement, eleve) VALUES (%s, CURDATE(), %s)", (somme, ideleve))
        cur.execute("INSERT INTO eleve_has_cours (ideleve, idcours, nb_achete, nb_rest) values (%s, %s, %s, %s)", (ideleve, idcours, nb_seances, nb_seances))
        mysql.connection.commit()
        cur.close()
        flash("Facture ajouté avec success", 'success')
        return redirect(url_for('index'))
    
    return render_template('affectation.html', ideleve=ideleve, form=form,  idcours = idcours, group_disp = group_disp, nb_seances = nb_seances, p = p )




    

def seance_disponible(cours, eleve):
    cur = mysql.connection.cursor()
    cur.execute('SELECT idgroupe from eleve_has_groupe where ideleve = %s', (eleve,))
    gro = cur.fetchall()
    if  gro:
        cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s and s.idgroupe  not in %s", (cours, gro) )
    else:
        cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s ", (cours,) )
    groups = cur.fetchall()
    cur.close()
    return groups
    




def groupe_disponible(cours):
    cur = mysql.connection.cursor()
    cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s ", (cours,) )
    groups = cur.fetchall()
    cur.close()
    return groups


@app.route('/delete_eleve/<int:id_eleve>', methods=['POST'])
@require_login
def delete_eleve(id_eleve):
    cur = mysql.connection.cursor()
    cur.execute('UPDATE groupe SET nombre_eleves = nombre_eleves - 1 where idgroupe in (select idgroupe from eleve_has_groupe where ideleve = %s)', (id_eleve,))
    cur.execute('DELETE FROM eleve WHERE id_eleve = %s', (id_eleve,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('eleves'))

@app.route('/delete_eleve_groupe/<int:id_eleve>', methods=['POST'])
@require_login
def delete_eleve_groupe(id_eleve):
    cur = mysql.connection.cursor()
    cur.execute('UPDATE groupe SET nombre_eleves = nombre_eleves - 1 where idgroupe in (select idgroupe from eleve_has_groupe where ideleve = %s)', (id_eleve,))
    cur.execute('DELETE from eleve_has_groupe where ideleve = %s', (id_eleve,))
    cur.execute('DELETE from eleve_has_cours where ideleve = %s', (id_eleve,))
    cur.execute('DELETE from eleve_has_seance where ideleve = %s', (id_eleve,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('index'))

@app.route('/groupes')
@require_login
def groupes():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM groupe')
    groupe_data = cur.fetchall()
    cur.close()
    return render_template("groupes.html", groupe_data = groupe_data)


# @app.route('/ajouter_groupe', methods=['GET', 'POST'])
# def ajouter_groupe():
#     form = AjtGroupeForm()

#     if form.validate_on_submit():
#         # Retrieve form data
#         nombre_eleves = form.nombre_eleves.data

#         # SQL query to insert data into the table
#         insert_query = """
#         INSERT INTO groupe (nombre_eleves)
#         VALUES (%s)
#         """
#         cur = mysql.connection.cursor()

#         # Execute the query with the form data
#         cur.execute(insert_query, (nombre_eleves,))
#         mysql.connection.commit()
#         cur.close()
#         flash('Ajout avec succès!', 'success')

#         return redirect(url_for('groupes'))  # Assuming you have a route named 'groupes'
#     return render_template('ajouter_groupe.html', form=form)

# @app.route('/delete_groupe/<int:idgroupe>', methods=['POST'])
# def delete_groupe(idgroupe):
#     cur = mysql.connection.cursor()
#     cur.execute('DELETE FROM groupe WHERE idgroupe = %s', (idgroupe,))
#     mysql.connection.commit()
#     cur.close()
#     return redirect(url_for('groupes')) 

# @app.route('/ajouter_seance', methods=['GET', 'POST'])
# def ajouter_seance():
#     form = AjtSeanceForm()

#     if form.validate_on_submit():
#         # Retrieve form data
#         type_séance = form.type_seance.data

#         # SQL query to insert data into the table
#         insert_query = """
#         INSERT INTO séance (type_séance)
#         VALUES (%s)
#         """
#         cur = mysql.connection.cursor()

#         # Execute the query with the form data
#         cur.execute(insert_query, (type_séance,))
#         mysql.connection.commit()
#         cur.close()
#         flash('Ajout avec succès!', 'success')

#         return redirect(url_for('seances'))  # Assuming you have a route named 'seances'
#     return render_template('ajouter_seance.html', form=form)


# @app.route('/delete_seance/<int:idseance>', methods=['POST'])
# def delete_seance(idseance):
#     cur = mysql.connection.cursor()
#     cur.execute('DELETE FROM séance WHERE idséance = %s', (idseance,))
#     mysql.connection.commit()
#     cur.close()
#     return redirect(url_for('seances'))


# @app.route('/seances')
# def seances():
#     cur = mysql.connection.cursor()
#     cur.execute('SELECT * FROM séance')
#     seances_data = cur.fetchall()
#     cur.close()
#     return render_template("seances.html", seances_data=seances_data)


# @app.route('/ajouter_facture', methods=['GET', 'POST'])
# def ajouter_facture():
#     form = AjtFactureForm()

#     if form.validate_on_submit():
#         # Retrieve form data
#         somme_total = form.somme_total.data
#         date_paiement = form.date_paiement.data

#         # SQL query to insert data into the table
#         insert_query = """
#         INSERT INTO facture (somme_total, date_paiement)
#         VALUES (%s, %s)
#         """
#         cur = mysql.connection.cursor()

#         # Execute the query with the form data
#         cur.execute(insert_query, (somme_total, date_paiement))
#         mysql.connection.commit()
#         cur.close()
#         flash('Ajout avec succès!', 'success')

#         return redirect(url_for('factures'))  # Assuming you have a route named 'factures'
#     return render_template('ajouter_facture.html', form=form)

@app.route('/factures')
@require_login
def factures():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM facture')
    factures_data = cur.fetchall()
    cur.close()
    return render_template("factures.html", factures_data=factures_data)

@app.route('/delete_facture/<int:id_facture>', methods=['POST'])
@require_login
def delete_facture(id_facture):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM facture WHERE idfacture = %s', (id_facture,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('factures'))


# @app.route('/ajouter_formation', methods=['GET', 'POST'])
# def ajouter_formation():
#     form = AjtFormationForm()

#     if form.validate_on_submit():
#         # Retrieve form data
#         nom_formation = form.nom_formation.data

#         # SQL query to insert data into the table
#         insert_query = """
#         INSERT INTO formation (nom_formation)
#         VALUES (%s)
#         """
#         cur = mysql.connection.cursor()

#         # Execute the query with the form data
#         cur.execute(insert_query, (nom_formation,))
#         mysql.connection.commit()
#         cur.close()
#         flash('Ajout avec succès!', 'success')

#         return redirect(url_for('formations')) 
#     return render_template('ajouter_formation.html', form=form)


# @app.route('/delete_formation/<int:id_formation>', methods=['POST'])
# def delete_formation(id_formation):
#     cur = mysql.connection.cursor()
#     cur.execute('DELETE FROM formation WHERE idformation = %s', (id_formation,))
#     mysql.connection.commit()
#     cur.close()
#     return redirect(url_for('formations'))


@app.route('/formations')
@require_login
def formations():
    return render_template("formations.html")




# @app.route('/professeur')
# @require_login
# def profs_list():
#     cursor = mysql.connection.cursor()
#     select_prof=""" SELECT * FROM enseignant; """
#     cursor.execute(select_prof)
#     professeurs= cursor.fetchall()  
#     return render_template('profs.html', professeurs=professeurs)

# @app.route('/ajouter_prof', methods=['GET', 'POST'])
# def ajouter_prof():
#     form = AjtProf()

#     if form.validate_on_submit():
#         # Retrieve form data
#         Cin_prof = form.Cin_prof.data
#         nom_prof = form.nom_prof.data
#         prenom_prof = form.prenom_prof.data
#         email_prof = form.email_prof.data
#         numtel_prof = form.numtel_prof.data

#         # SQL query to insert data into the table
#         insert_query = """
#         INSERT INTO enseignant (Cin_prof, nom_enseignant, prenom_enseignant, email_enseignant, numtel_enseignant)
#         VALUES (%s, %s, %s, %s, %s)
#         """

#         # Execute the query with the form data
#         cursor = mysql.connection.cursor()
#         cursor.execute(insert_query, (Cin_prof, nom_prof, prenom_prof, email_prof, numtel_prof))
#         mysql.connection.commit()
#         flash('Ajout avec succès!', 'success')

#         return render_template('ajouter_prof.html', message = "Ajouter avec success",form=form)

#     return render_template('ajouter_prof.html', form=form)

# @app.route('/delete_prof/<int:idenseignant>', methods=['POST'])
# def delete_prof(idenseignant):
#     cur = mysql.connection.cursor()
#     cur.execute('DELETE FROM enseignant WHERE idenseignant = %s', (idenseignant,))
#     mysql.connection.commit()
#     cur.close()
#     return redirect(url_for('profs_list')) 

@app.route('/valider_absences/<int:idgroupe>', methods=['POST'])
@require_login
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
                               SET nb_rest = nb_rest - 1
                               WHERE ideleve = %s AND nb_rest <> 0 and idcours IN
                                   (SELECT idcours FROM séance WHERE idséance = %s)''', (ideleve, idseance))
                mysql.connection.commit()

        for ideleve in eleves_absents_ids:
            # Incrémenter le nb_abscences des élèves absents
            cur.execute('''UPDATE eleve_has_seance
                           SET abscence = abscence + 1
                           WHERE ideleve = %s AND idseance = %s''', (ideleve, idseance))
            mysql.connection.commit()

            # Vérifier si le nombre d'absences est supérieur ou égal à 2
            cur.execute('''SELECT abscence FROM eleve_has_seance
                           WHERE ideleve = %s AND idseance = %s''', (ideleve, idseance))
            nb_abscence = cur.fetchone()[0]

            if nb_abscence >= 2:
                # Mettre à jour nb_seances_rest si nb_abscence >= 2
                cur.execute('''UPDATE eleve_has_cours
                               SET nb_rest = nb_rest - 1
                               WHERE ideleve = %s AND idcours IN
                                   (SELECT idcours FROM séance WHERE idséance = %s)''', (ideleve, idseance))
                mysql.connection.commit()        

        cur.close()
        flash('Les absences ont été enregistrées avec succès!', 'success')
        return redirect(url_for('gerer_abs_groupe', idgroupe=idgroupe))



@app.route('/gerer_abs_groupe/<int:idgroupe>', methods=['GET', 'POST']) 
@require_login
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
        cur.execute('SELECT abscence FROM eleve_has_seance WHERE ideleve IN (SELECT ideleve FROM eleve_has_groupe WHERE idgroupe = %s) AND idseance = %s', (idgroupe,idseance,))
        nbs=cur.fetchall()
        cur.execute('SELECT idcours FROM séance WHERE idséance=%s',(idseance,))
        idcours=cur.fetchone()
        cur.execute('SELECT formation_idformation from cours where idcours = %s', (idcours,))
        idformation = cur.fetchone()
        cur.execute('SELECT nb_rest FROM eleve_has_cours WHERE idcours=%s AND ideleve IN (SELECT ideleve FROM eleve_has_groupe WHERE idgroupe = %s)',(idcours,idgroupe,))
        nombre_seances_rest=cur.fetchall()
        cur.close()

        return render_template('gerer_abs.html', eleves_groupe=eleves_groupe, idgroupe=idgroupe,nbs=nbs,nombre_seances_rest=nombre_seances_rest, idcours = idcours, idformation = idformation)


# @app.route('/acheter_seance/<int:ideleve>', methods=['GET', 'POST'])
# def acheter_seance(ideleve):
#     form = AchtSeanceForm()

#     if form.validate_on_submit():
#         idcours = form.idcours.data
#         idgroupe = form.idgroupe.data  
#         nb_seances_ach = form.nb_seances_ach.data
#         prix_a_payer = 150 * nb_seances_ach  

#         cur = mysql.connection.cursor()
#         print(idgroupe)
#         cur.execute('SELECT idséance FROM séance WHERE idgroupe = %s',(idgroupe,))
#         idseance = cur.fetchone()[0]

#         cur.execute('''UPDATE eleve_has_cours
#                SET nb_seances_achetees = %s
#                WHERE ideleve = %s AND idcours = %s''', (nb_seances_ach, ideleve, idcours))

#         cur.execute('''UPDATE eleve_has_cours
#                SET nb_seances_rest = %s
#                WHERE ideleve = %s AND idcours = %s''', (nb_seances_ach, ideleve, idcours))

#         cur.execute('''UPDATE eleve_has_seance
#                SET nb_abscence = 0
#                WHERE ideleve = %s AND idseance = %s''', (ideleve, idseance))


#         mysql.connection.commit()

#         return render_template('mafacture.html', ideleve=ideleve, idcours=idcours, idgroupe=idgroupe, nb_seances_ach=nb_seances_ach, prix_a_payer=prix_a_payer)

#     return render_template('acheter_seance.html', form=form, ideleve=ideleve)


@app.route('/profs', methods=['POST', 'GET'])
@require_login
def profs():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * from enseignant')
    proff = cur.fetchall()
    cur.execute('SELECT c.nom_course, s.enseignant_idenseignant, s.idséance from cours c, séance s where c.idcours = s.idcours')
    cours = cur.fetchall()
    cur.close()
    return render_template('profs.html', proff = proff, cours = cours)


@app.route("/afficher_seance", methods=['POST', 'GET'])
@require_login
def afficher_seance():
    idprof = request.args.get('idprof')
    cur = mysql.connection.cursor()
    cur.execute('SELECT type_séance, jour, debut, fin, classe from séance  where enseignant_idenseignant = %s', (idprof,))
    seances = cur.fetchall()
    cur.execute('SELECT nom_enseignant, prenom_enseignant from enseignant where idenseignant = %s', (idprof,))
    prof = cur.fetchone()
    cur.close()
    return render_template('afficher_seance.html', idprof = idprof, seances = seances, prof = prof)


if __name__ == "__main__":
    app.run(debug=True)
