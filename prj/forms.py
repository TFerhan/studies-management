from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SubmitField, PasswordField,EmailField
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

class AjtProf(FlaskForm):
    Cin_prof = StringField('CIN professeur', validators=[DataRequired()])
    nom_prof = StringField('Nom du Professeur', validators=[DataRequired()])
    prenom_prof = StringField('Prenom du Professeur', validators=[DataRequired()])
    email_prof = EmailField('Email Professeur', validators=[DataRequired(), Email()])
    numtel_prof = StringField('numero de telephone', validators=[DataRequired(), Length(max=14)])
    submit = SubmitField("Ajouter le Professeur")


class AjtGroupeForm(FlaskForm):
    nombre_eleves = StringField('Nombre d\'élèves', validators=[DataRequired()])
    submit = SubmitField('Ajouter Groupe')

class AjtSeanceForm(FlaskForm):
    type_seance = StringField('Type de séance', validators=[DataRequired()])
    submit = SubmitField('Ajouter Séance')

class AjtFactureForm(FlaskForm):
    somme_total = IntegerField('Somme Totale', validators=[DataRequired()])
    date_paiement = DateField('Date de Paiement',validators=[DataRequired()])
    submit = SubmitField('Ajouter Facture')

class AjtFormationForm(FlaskForm):
    nom_formation = StringField('Nom de Formation', validators=[DataRequired()])
    submit = SubmitField('Ajouter Formation')
