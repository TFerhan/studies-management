from flask import Flask, render_template, abort, request, flash
from flask import session, redirect, url_for
from forms import AjtEleveForm, LoginForm
import mysql.connector


app = Flask(__name__)
app.config['SECRET_KEY'] = 'hola'


db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'psplus14',
    'database': 'mydb'
}

conn = mysql.connector.connect(**db_config)
cursor = conn.cursor()
@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()  # Create an instance of the LoginForm

    if form.validate_on_submit():
        username = form.username.data
        password = form.password.data

        if username in users and users[username] == password:
            return f'Welcome, {username}!'
        else:
            return 'Invalid username or password. Please try again.'

    return render_template('login.html', form=form)

@app.route("/eleves")
def eleves():
    selectionner = """
    SELECT * FROM Eleve;
    """
    cursor.execute(selectionner)
    eleves_data = cursor.fetchall()
    return render_template("eleves.html", eleves_data = eleves_data)


@app.route('/ajouter_eleve', methods=['GET', 'POST'])
def ajouter_eleve():
    form = AjtEleveForm()

    if form.validate_on_submit():
        # Retrieve form data
        nom_ev = form.nom_ev.data
        prenom_ev = form.prenom_ev.data
        email_ev = form.email_ev.data
        numtel_ev = form.numtel_ev.data
        numtel_par = form.numtel_par.data
        date_inscrit = form.date_inscrit.data
        nb_absence = form.nb_absence.data

        # SQL query to insert data into the table
        insert_query = """
        INSERT INTO Eleve (nom_ev, prenom_ev, email_ev, numtel_ev, numtel_par, date_inscrit, nb_absence)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        """

        # Execute the query with the form data
        cursor.execute(insert_query, (nom_ev, prenom_ev, email_ev, numtel_ev, numtel_par, date_inscrit, nb_absence))
        conn.commit()
        flash('Ajout avec succès!', 'success')

        return render_template('ajouter_eleve.html', message = "Ajouter avec success")

    return render_template('ajouter_eleve.html', form=form)



if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
