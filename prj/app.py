from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, AjtProf, LoginForm
from flask_mysqldb import MySQL



app = Flask(__name__)
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_HOST'] = '127.0.0.1' # localht
app.config['MYSQL_DB'] = 'mydb'

app.config['SECRET_KEY'] = 'WlUrPgXjHOL9OquLGcQ96yfoZOyNLfCYFV05NUQN9DE3Fb4tUcWW02s4pYySzeDj'

mysql = MySQL(app)
@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm() 

    if form.validate_on_submit():
        username = form.username.data
        password = form.password.data
        
        select_admin = """SELECT * FROM admins WHERE username = %s AND password = %s"""
        cursor.execute(select_admin, (username, password))
        admin_data = cursor.fetchall() 

        if admin_data:
            return f'Welcome, {username}!'
        else:
            return 'Invalid username or password. Please try again.'

    return render_template('login.html', form=form)




@app.route('/professeur')
def profs_list():
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
        cursor.execute(insert_query, (Cin_prof, nom_prof, prenom_prof, email_prof, numtel_prof))
        conn.commit()
        flash('Ajout avec succès!', 'success')

        return render_template('ajouter_prof.html', message = "Ajouter avec success",form=form)

    return render_template('ajouter_prof.html', form=form)


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



if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
