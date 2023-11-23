from flask import Flask, render_template, abort, request
from flask import session, redirect, url_for



app = Flask(__name__)

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
    return render_template("eleves.html")

@app.route("/ajouter_eleve")
def ajouter_eleve():
    return render_template("ajouter_eleve.html")


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
