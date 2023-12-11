@app.route('/affectation', methods=['GET', 'POST'])
def affectation():
    form = Selectgrp()
    
    ideleve = request.args.get('ideleve')
    idformation = request.args.get('idformation')
    idcours = request.args.get('idcours')
    group_disp = request.args.get('group_disp') 
    nb_seances = request.args.get('nb_seances')
    flash('gr = {}'.format(group_disp), 'success')
    form.group.choices = list(group_disp[4])

    if form.validate_on_submit():
        selected_groups = form.group.data
        groups = tuple(group[0] for group in selected_groups)
        flash('Group = {}'.format(groups), 'success')
        cur = mysql.connection.cursor()
        cur.execute("UPDATE groupe SET nombre_eleves = nombre_eleves + 1 where idgroupe in %s ", (groups,))
        for g in groups:
            cur.execute("INSERT INTO eleve_has_groupe (ideleve, idgroupe) values (%s, %s, %s)", (ideleve, g) )
        
        cur.execute("INSERT INTO eleve_has_cours (ideleve, idcours, nb_achete) values (%s, %s, %s)", (ideleve, idcours, nb_seances))
        
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('factures', ideleve = ideleve, nb_seances = nb_seances ))
    
    return render_template('affectation.html', ideleve=ideleve, form=form, idformation=idformation, idcours = idcours, group_disp = group_disp )