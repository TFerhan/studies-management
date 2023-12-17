from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, Achtcours, LoginForm, MDPOUB, Ajtcours, Selectgrp, AchtSeanceForm, Filtrer, filtr, searchelv, ModifierP, AjtUtilisateur
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
    username = session['username']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * from admins where username = %s", (username,))
    admin_data = cur.fetchall()[0]
    cur.close()
    return render_template('index.html', username = username, admin_data = admin_data)

@app.route('/modifier', methods=['POST', 'GET'])
@require_login
def modifier_profile():
    form = ModifierP()
    username = session['username']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * from admins where username = %s", (username,))
    admin_data = cur.fetchall()[0]
    if form.validate_on_submit():
        nom = form.nom.data
        prenom = form.prenom.data
        mdp_anc = form.mdp_anc.data
        mdp_nv = form.mdp_nv.data
        if mdp_nv and not mdp_anc:
            flash('Veuillez entrer votre mot de passe !!')
            return redirect(url_for('index'))
        
        mdp_org = admin_data[5]
        if mdp_anc:
            if (mdp_anc != mdp_org):
                flash('Mot de passe incorrect. Ressayer')
                return redirect(url_for('modifier_profile', username = username))
            else:
                if nom:
                    cur.execute('UPDATE admins set nom = %s where username = %s', (nom, username,))
                    mysql.connection.commit()
                if prenom:
                    cur.execute('UPDATE admins set prenom = %s where username = %s', (prenom, username,))
                    mysql.connection.commit()
                if mdp_nv:
                    cur.execute('UPDATE admins set password = %s where username = %s', (mdp_nv, username,))
                    mysql.connection.commit()
                flash("Informations modifiés avec success")
                return redirect(url_for('profile'))
        return redirect(url_for('modifier_profile', username = username))
    return render_template('modifier_profile.html', form = form, username = username, admin_data = admin_data )


@app.route('/ajouter_utilisateur', methods=['GET', 'POST'])
@require_login
def ajouter_utilisateur():
    form = AjtUtilisateur()
    if form.validate_on_submit():
        nom = form.nom.data
        prenom = form.prenom.data
        cin = form.cin.data
        username = form.username.data
        mdp = form.mdp.data
        re_mdp = form.re_mdp.data
        role = form.role.data
        if re_mdp != mdp:
            flash('Mots de passe incompatibles')
            return redirect(url_for('ajouter_utilisateur'))
        
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO admins ( nom, prenom, role, username, password, CIN) VALUES (%s, %s, %s, %s, %s, %s) ", (nom, prenom, role, username, mdp, cin ))
        mysql.connection.commit()
        cur.close()

        flash("Ajouté avec success")
        return redirect(url_for('index'))
    return render_template('ajouter_utilisateur.html', form = form)


@app.route('/profile', methods = ['POST', 'GET'])
@require_login
def profile():
    username = session['username']
    cur = mysql.connection.cursor()
    cur.execute("SELECT * from admins where username = %s", (username,))
    admin_data = cur.fetchall()[0]
    cur.close()
    return render_template('profile.html',  admin_data = admin_data)   

@app.route('/mdp_oublie', methods=['GET', 'POST'])
def mdp_oublie():
    form = MDPOUB()

    if form.validate_on_submit():
        cin = form.cin.data
        cur = mysql.connection.cursor()
        cur.execute('Select id_admin from admins where CIN = %s', (cin,))
        p = cur.fetchone()
        if not p:
            flash( 'Aucun CIN de cette valeur. Veuillez contacter votre administrateur' , 'error')
            return redirect(url_for('mdp_oublie'))
        nv_mdp = form.nv_mdp.data
        verf_mdp = form.verf_mdp.data
        if nv_mdp != verf_mdp:
            flash(category= 'error', message = 'Veuillez entrer les memes mots de passe')
            return redirect(url_for('mdp_oublie'))
        cur.execute('UPDATE admins set password = %s where id_admin = %s', (nv_mdp, p[0]))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('login'))
    return render_template('mdp_oublie.html', form = form)
        


@app.route('/search_eleves', methods=['GET', 'POST'])
def search_eleves():
    form = searchelv()
    if form.validate_on_submit():
        result = []
        nom = form.nom.data 
        prenom = form.prenom.data
        cours = form.cours.data
        cur = mysql.connection.cursor()
        cur.execute('select * from eleve where nom_ev = %s', (nom,))
        nelv = cur.fetchall()
        print(nelv)
        if nelv :
            result.append(nelv)
        cur.execute('select * from eleve  where prenom_ev = %s', (prenom,))
        pelv = cur.fetchall()

        if pelv:
            result.append(pelv)
        cur.execute('select e.* from eleve e, eleve_has_cours ec where  e.id_eleve = ec.ideleve and idcours in (select idcours from cours where nom_course = %s)', (cours,))
        celv = cur.fetchall()
        if celv:
            result.append(celv)
        cur.execute('select count(DISTINCT ec.idcours) from eleve_has_cours ec,eleve e where ec.ideleve=e.id_eleve group by e.id_eleve')
        if not result:
            flash('Aucun eleve trouvé', 'success')
            return redirect(url_for('eleves'))
        nbcourseleve=cur.fetchall()
        eleves_data = result[0]
        cur.close()
        return render_template("eleves.html", eleves_data=eleves_data, form = form, nbcourseleve = nbcourseleve)
    return render_template("eleves.html", form = form)



@app.route('/filtrer', methods=['POST', 'GET'])
def filtrer():
    form = Filtrer()
    if form.validate_on_submit():
        filters = []
        parameters = []
        nomcours = []
        if form.jour.data:
            filters.append('jour = %s')
            parameters.append(form.jour.data)
        if form.debut.data:
            filters.append('debut BETWEEN %s AND %s')
            parameters.extend([form.debut.data, form.fin.data])
        if form.classe.data:
            filters.append('classe = %s')
            parameters.append(form.classe.data)
        where_req = ' AND '.join(filters) if filters else '1'

        cur = mysql.connection.cursor()
        req =  f'SELECT s.idgroupe, g.nombre_eleves FROM séance s, groupe g WHERE {where_req} and s.idgroupe = g.idgroupe'
        cur.execute(req, parameters)
        groupe_data = cur.fetchall()
        for i in groupe_data:
            cur.execute('select c.nom_course from cours c, séance s where c.idcours = s.idcours and s.idgroupe = %s', (i[0],))
            nomcours.append(cur.fetchone())
        cur.close()
        return render_template('groupes.html', form = form , groupe_data = groupe_data, nomcours = nomcours)
    return render_template('groupes.html', form = form )





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
        admin_data = cursor.fetchall()[0]

        if admin_data:
            session['username'] = username
            return render_template('index.html',username=username, admin_data = admin_data)
        else:
            return render_template('login.html', form=form, username = username)

    return render_template('login.html', form=form)


@app.route('/logout')
def logout():
    session.pop('username', None) 
    return redirect(url_for('login'))

@app.route("/eleves", methods = ['GET', 'POST'])
@require_login
def eleves():
    form = searchelv()
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM eleve')
    eleves_data = cur.fetchall()
    cur.execute('select count(DISTINCT ec.idcours) from eleve_has_cours ec,eleve e where ec.ideleve=e.id_eleve group by e.id_eleve')
    nbcourseleve=cur.fetchall()
    print(nbcourseleve) 
    cur.close()
    return render_template("eleves.html", eleves_data = eleves_data,nbcourseleve=nbcourseleve, form = form)


@app.route('/filt', methods=['GET', 'POST'])
def filt():

    form = filtr()
    if form.validate_on_submit():
        result = []
        nom = form.nom.data
        prenom = form.prenom.data

        cur = mysql.connection.cursor()
        cur.execute('select e.nom_ev, e.prenom_ev, f.idfacture, f.somme_total, f.date_paiement, f.eleve from eleve e, facture f where e.nom_ev = %s and f.eleve = e.id_eleve', (nom,))
        nfac = cur.fetchall()
        if nfac:
            result.append(nfac)
        cur.execute('select e.nom_ev, e.prenom_ev, f.idfacture, f.somme_total, f.date_paiement, f.eleve from eleve e, facture f where e.prenom_ev = %s and f.eleve = e.id_eleve', (prenom,))
        pfac = cur.fetchall()
        if pfac:
            result.append(pfac)
        if not result:
            flash('Facture introuvable', 'error')
            return redirect(url_for('factures'))
        factures_data = result[0]
        cur.close()
        return render_template('factures.html', form = form, factures_data = factures_data)
    
    return render_template('factures.html', form = form)





@app.route('/ajouter_eleve', methods=['GET', 'POST'])
@require_login
def ajouter_eleve():
    ideleve = request.args.get('ideleve')
    c = request.args.get('c')
    c = int(c)
    
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
                
                nom_ev = form.nom_ev.data
                prenom_ev = form.prenom_ev.data
                email_ev = form.email_ev.data
                phone_ev = form.numtel_ev.data
                numtel_par = form.numtel_par.data
                date_inscrit = form.date_inscrit.data
                test = form.test.data

                
                insert_query = """
                INSERT INTO Eleve (nom_ev, prenom_ev, email_ev, phone_ev, numtel_par, date_inscrit, test)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
                """
                cur = mysql.connection.cursor()

                
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
                cur.execute("INSERT INTO facture (somme_total, date_paiement, eleve) VALUES (%s, CURDATE(), %s)", (200, ideleve))
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

@app.route('/afficher_membres', methods=['GET', 'POST'])
@require_login
def afficher_membres():
    idgroupe = request.args.get('idgroupe')
    cur = mysql.connection.cursor()
    cur.execute('SELECT e.prenom_ev, e.nom_ev from eleve e, eleve_has_groupe eg where eg.idgroupe = %s and eg.ideleve = e.id_eleve ', (idgroupe,))
    membres = cur.fetchall()
    return render_template('afficher_membres.html', membres = membres)

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
        cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin,  s.type_séance FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s and s.idgroupe  not in %s", (cours, gro) )
    else:
        cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin,  s.type_séance FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s ", (cours,) )
    groups = cur.fetchall()
    cur.close()
    return groups
    


def groupe_disponible(cours):
    cur = mysql.connection.cursor()
    cur.execute("SELECT g.idgroupe, s.jour, s.debut, s.fin,  s.type_séance FROM groupe g , séance s WHERE s.idgroupe = g.idgroupe and g.nombre_eleves < 8 and s.idcours = %s ", (cours,) )
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

@app.route('/groupes', methods=['GET', 'POST'])
@require_login
def groupes():
    form = Filtrer()
    nomcours = []
    c = []
    cur = mysql.connection.cursor()
    cur.execute('SELECT * FROM groupe')
    groupe_data = cur.fetchall()
    for i in groupe_data:
        cur.execute('select c.nom_course from cours c, séance s where c.idcours = s.idcours and s.idgroupe = %s', (i[0],))
        nomcours.append(cur.fetchone())
    cur.close()
    return render_template("groupes.html", form = form, groupe_data = groupe_data, nomcours = nomcours, c = c)



@app.route('/factures')
@require_login
def factures():
    form = filtr()
    cur = mysql.connection.cursor()
    cur.execute('select e.nom_ev, e.prenom_ev, f.idfacture, f.somme_total, f.date_paiement, f.eleve from eleve e, facture f where f.eleve = e.id_eleve ')
    factures_data = cur.fetchall()
    cur.close()
    return render_template("factures.html", factures_data=factures_data, form = form)

@app.route('/delete_facture/<int:id_facture>', methods=['POST'])
@require_login
def delete_facture(id_facture):
    cur = mysql.connection.cursor()
    cur.execute('DELETE FROM facture WHERE idfacture = %s', (id_facture,))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('factures'))



@app.route('/formations')
@require_login
def formations():
    return render_template("formations.html")



@app.route('/valider_absences/<int:idgroupe>', methods=['POST'])
@require_login
def valider_absences(idgroupe, c=[]):
    

    if request.method == 'POST':
        eleve_absent_id = request.args.get('eleve')
        if eleve_absent_id:
            c.append(eleve_absent_id)
            print(c)
            cur = mysql.connection.cursor()
            cur.execute('SELECT idséance FROM séance WHERE idgroupe = %s', (idgroupe,))
            idseance = cur.fetchone()[0]

            cur.execute('''UPDATE eleve_has_seance
                           SET abscence = abscence + 1
                           WHERE ideleve = %s AND idseance = %s''', (eleve_absent_id, idseance))
            mysql.connection.commit()
            cur.close()
            flash('Les absences ont été enregistrées avec succès!', 'success')

    return redirect(url_for('gerer_abs_groupe', idgroupe=idgroupe, c=c))

@app.route('/v_presence', methods=['POST'])
@require_login
def v_presence():
    
    if request.method == 'POST':
        idgroupe = request.args.get('idgroupe')
        eleves_id = [eleve.strip('(,)') for eleve in request.args.getlist('eleves')]
        c = request.args.getlist('c')
        print("eleves_id:", eleves_id)
        print(c)
        cur = mysql.connection.cursor()
        cur.execute('SELECT idséance FROM séance WHERE idgroupe = %s', (idgroupe,))
        idseance = cur.fetchone()[0]
        for eleve in eleves_id:
            if eleve[0] in c:
                cur.execute('SELECT abscence FROM eleve_has_seance WHERE ideleve = %s AND idseance = %s', (eleve, idseance))
                nb_abs = cur.fetchone()[0]
                if nb_abs >= 2:
                    cur.execute('''UPDATE eleve_has_cours
                                SET nb_rest = nb_rest - 1
                                WHERE ideleve = %s AND idcours IN
                                    (SELECT idcours FROM séance WHERE idséance = %s)''', (eleve, idseance))
                    mysql.connection.commit() 
            else:
                cur.execute('''UPDATE eleve_has_cours
                               SET nb_rest = nb_rest - 1
                               WHERE ideleve = %s AND nb_rest <> 0 and idcours IN
                                   (SELECT idcours FROM séance WHERE idséance = %s)''', (eleve, idseance))
                mysql.connection.commit() 
        return redirect(url_for('gerer_abs_groupe', idgroupe = idgroupe))
                           



@app.route('/gerer_abs_groupe/<int:idgroupe>', methods=['GET', 'POST'])
@require_login
def gerer_abs_groupe(idgroupe, c=None):
    if c is None:
        c = []
        
        cur = mysql.connection.cursor()
        cur.execute(''' 
            SELECT e.id_eleve, e.prenom_ev, e.nom_ev
            FROM eleve e
            INNER JOIN eleve_has_groupe eg ON e.id_eleve = eg.ideleve
            WHERE eg.idgroupe = %s
        ''', (idgroupe,))
        eleves_groupe = cur.fetchall()
        cur.execute(''' 
            SELECT e.id_eleve
            FROM eleve e
            INNER JOIN eleve_has_groupe eg ON e.id_eleve = eg.ideleve
            WHERE eg.idgroupe = %s
        ''', (idgroupe,))
        eleves_id = cur.fetchall()

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

        return render_template('gerer_abs.html', eleves_groupe=eleves_groupe, idgroupe=idgroupe,nbs=nbs,nombre_seances_rest=nombre_seances_rest, idcours = idcours, idformation = idformation, c = c, eleves_id = eleves_id)




@app.route('/profs', methods=['POST', 'GET'])
@require_login
def profs():
    cur = mysql.connection.cursor()
    cur.execute('SELECT * from enseignant')
    proff = cur.fetchall()
    cur.execute('SELECT DISTINCT c.nom_course, s.enseignant_idenseignant from cours c, séance s where c.idcours = s.idcours')
    cours = cur.fetchall()
    print(cours)
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


@app.route('/statistiques')
@require_login
def statistiques():

    cur=mysql.connection.cursor()

    cur.execute('select count(*) FROM eleve')

    nbeleve=cur.fetchone()

    cur.execute('select count(*) from enseignant')
    nbenseignant=cur.fetchone()
    cur.execute('select distinct eg.idcours,c.nom_course,count(eg.ideleve) from eleve_has_cours eg, cours c  where eg.idcours=c.idcours group by idcours')
    nbelevecours=cur.fetchall()
    cur.execute('select count(*) from cours')
    nbcours=cur.fetchone()
    cur.execute('select count(*) from eleve where test = 1')
    nbtest=cur.fetchone()
    cur.execute('select count(*) from formation')
    nbformation=cur.fetchone()
    cur.execute('''SELECT YEAR(date_paiement) AS Annee, MONTH(date_paiement) AS Mois, SUM(somme_total) AS Somme_Par_Mois
                    FROM facture
                    GROUP BY YEAR(date_paiement), MONTH(date_paiement)
                ''')
    sommeparmois=cur.fetchall()
    
    return render_template('statistique.html',nbtest=nbtest,nbeleve=nbeleve,nbenseignant=nbenseignant,nbelevecours=nbelevecours,sommeparmois=sommeparmois,nbcours=nbcours,nbformation=nbformation)

if __name__ == "__main__":
    app.run(debug=True)
