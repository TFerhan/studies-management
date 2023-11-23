from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SubmitField, PasswordField
from wtforms.validators import DataRequired, Email, Length

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    submit = SubmitField('Login')

class AjtEleveForm(FlaskForm):
    nom_ev = StringField('Nom', validators=[DataRequired(), Length(max=45)])
    prenom_ev = StringField('Prénom', validators=[DataRequired(), Length(max=45)])
    email_ev = StringField('Email', validators=[Email(), Length(max=45)])
    numtel_ev = StringField('Numéro de téléphone élève', validators=[Length(max=20)])
    numtel_par = StringField('Numéro de téléphone des parents', validators=[DataRequired(), Length(max=20)])
    date_inscrit = DateField('Date d\'inscription', validators=[DataRequired()])
    nb_absence = IntegerField('Nombre d\'absence', default=0, validators=[DataRequired()])
    submit = SubmitField("Ajouter l'élève")

