from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SubmitField, PasswordField, EmailField, SelectField, BooleanField, RadioField, SelectMultipleField
from wtforms.validators import DataRequired, Email, Length, InputRequired, NumberRange

class AjtEleveForm(FlaskForm):
    nom_ev = StringField('Nom', validators=[DataRequired(), Length(max=45)])
    prenom_ev = StringField('Prénom', validators=[DataRequired(), Length(max=45)])
    email_ev = StringField('Email', validators=[Email(), Length(max=45)])
    numtel_ev = StringField('Numéro de téléphone élève', validators=[Length(max=20)])
    numtel_par = StringField('Numéro de téléphone des parents', validators=[DataRequired(), Length(max=20)])
    date_inscrit = DateField('Date d\'inscription', validators=[DataRequired()])
    formation = SelectField('Formation', coerce= int, choices = [], validators=[DataRequired()])
    nb_seances = IntegerField()
    test = BooleanField("Seance de test ?")
    submit = SubmitField("Suivant")

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


class LoginForm(FlaskForm):
    username = StringField('Nom d\'utilisateur', validators=[DataRequired()])
    password = PasswordField('Mot de passe', validators=[DataRequired()])
    submit = SubmitField('Se connecter')


class AjtProf(FlaskForm):
    Cin_prof = StringField('CIN professeur', validators=[DataRequired()])
    nom_prof = StringField('Nom du Professeur', validators=[DataRequired()])
    prenom_prof = StringField('Prenom du Professeur', validators=[DataRequired()])
    email_prof = EmailField('Email Professeur', validators=[DataRequired(), Email()])
    numtel_prof = StringField('numero de telephone', validators=[DataRequired(), Length(max=14)])
    submit = SubmitField("Ajouter le Professeur")


class Ajtcours(FlaskForm):
    cours = SelectField('Cours', choices=[], validators=[DataRequired()])
    nb_seances =  IntegerField('Saisir le nombre de séances acheté', validators = [NumberRange(min= 2, message="2 seances au minimum")])
    submit = SubmitField("Suivant")




class Selectgrp(FlaskForm):
    group = SelectMultipleField('Selectionne un groupe', choices = [],  validators = [DataRequired()])
    submit = SubmitField('Suivant')


class AjtFacture(FlaskForm):
    date = DateField('Date de paimment', validators = [DataRequired()])
    submit = SubmitField("Terminer")

class AchtSeanceForm(FlaskForm):
    nb_seances_ach=IntegerField('nombre de seances a ajouter',validators=[DataRequired()])
    submit = SubmitField('Valider')

class Achtcours(FlaskForm):
    formation = SelectField('Formation', coerce= int, choices = [], validators=[DataRequired()])
    submit = SubmitField('Suivant')


class MDPOUB(FlaskForm):
    cin = StringField('Entrer votre CIN', validators = [DataRequired()])
    nv_mdp = PasswordField('Entrer un nouveau mot de passe', validators = [DataRequired()])
    verf_mdp = PasswordField('Verfier', validators=[DataRequired()])
    submit = SubmitField('Renitialiser le mot de passe')