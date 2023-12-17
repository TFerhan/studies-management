from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SubmitField, PasswordField, EmailField, SelectField, BooleanField, TimeField, SelectMultipleField
from wtforms.validators import DataRequired, Email, Length, InputRequired, NumberRange, ValidationError

class AjtEleveForm(FlaskForm):
    nom_ev = StringField('Nom', validators=[DataRequired(), Length(max=45)])
    prenom_ev = StringField('Prénom', validators=[DataRequired(), Length(max=45)])
    email_ev = StringField('Email', validators=[Email(), Length(max=45)])
    numtel_ev = StringField('Numéro de téléphone élève', validators=[Length(max=20)])
    numtel_par = StringField('Numéro de téléphone des parents', validators=[Length(max=20)])
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
    nb_seances =  IntegerField('Saisir le nombre de séances acheté', validators = [NumberRange(min= 2 , message="2 seances au minimum ")])
    submit = SubmitField("Suivant")


class Filtrer(FlaskForm):
    jour = SelectField('Jour', choices = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi'])
    debut = TimeField('Debut', validators = [DataRequired()])
    fin = TimeField('Fin', validators = [DataRequired()])
    classe = StringField('Classe')
    submit = SubmitField('Filtrer')





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


class filtr(FlaskForm):
    nom = StringField('Nom')
    prenom = StringField('Prenom')
    submit = SubmitField('Filtrer')


class searchelv(FlaskForm):
    nom = StringField('Nom')
    prenom = StringField('Prenom')
    cours = StringField('Cours')
    submit = SubmitField('Filrer')



class ModifierP(FlaskForm):
    nom = StringField('Nouveau nom')
    prenom = StringField('Nouveau prenom')
    mdp_anc = PasswordField('Entrer votre mot de passe ', validators=[ DataRequired()])
    mdp_nv = PasswordField('Entrer le nouveau mot de passe ', validators = [DataRequired()])
    submit = SubmitField('Enregistrer')


class AjtUtilisateur(FlaskForm):
    nom = StringField('Nom', validators=[DataRequired()])
    prenom = StringField('Prenom', validators=[DataRequired()])
    cin = StringField('CIN', validators=[DataRequired()])
    username = StringField("Nom d'utilisateur", validators=[DataRequired()])
    mdp = PasswordField("Mot de Passe", validators=[DataRequired(), Length(min=8, message = "Au moins 8 caractères")])
    re_mdp = PasswordField("Repetez Mot de Passe", validators=[DataRequired()])
    role = BooleanField("Cocher si pour  un Admin")
    submit = SubmitField("Ajouter Utilisateur")
