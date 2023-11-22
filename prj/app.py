from flask import Flask, render_template, abort, request
from flask import session, redirect, url_for



app = Flask(__name__)



@app.route("/eleves")
def eleves():
    return render_template("eleves.html")

@app.route("/ajouter_eleve")
def ajouter_eleve():
    return render_template("ajouter_eleve.html")


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3000)
