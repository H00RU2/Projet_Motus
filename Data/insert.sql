SET SERVEROUTPUT ON;

-- Procédure pour insérer les collections
create or replace procedure inserer_collection(
    vCollection Collection.idCollection%type
--    pretour OUT number
) AS
    exception_nbcollection exception;
    pragma exception_init(exception_nbcollection, -02290);
begin
    insert into Collection values (vCollection);
    commit;
--    pretour:=0;
Exception
    When Dup_val_on_index Then
        DBMS_OUTPUT.PUT_LINE('La collection existe déjà ');
--        pretour:=1;
    when exception_nbcollection then
        DBMS_OUTPUT.PUT_LINE('Le numéro de collection nest pas entre 1 et 5');
--        pretour := 2;
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || sqlerrm);
--        pretour := 3;
End;
/

accept vCollection  prompt 'Entrer un numéro de collection'
Begin
    inserer_collection(&vCollection);
End;
/

-- Procédure pour insérer les niveaux
create or replace procedure inserer_niveau (
    vidniveau niveau.idNiveau%type,
    vcollection niveau.idCollection%type, 
    vnbessai niveau.nb_essai%type,
    vtemps_max niveau.temps_max%type
--    pretour out number
) AS
    exception_nbessai exception;
    pragma exception_init(exception_nbessai, -02290);
    exception_foreign exception;
    pragma exception_init(exception_foreign, -02291);
begin
    insert into niveau values (vidniveau, vcollection, vnbessai, vtemps_max);
    commit;
--    pretour := 0;
Exception
    When Dup_val_on_index Then
        DBMS_OUTPUT.PUT_LINE('le niveau existe déjà ');
--        pretour := 1;
    when exception_nbessai then
        DBMS_OUTPUT.PUT_LINE('Le nombre dessai nest pas dans les normes');
--        pretour := 2;
    when exception_foreign then
        DBMS_OUTPUT.PUT_LINE('La collection nexiste pas');
--        pretour := 3;
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || sqlerrm);
--        pretour := 4;
End;
/

accept vidniveau prompt 'Entrer un numéro de niveau'
accept vcollection prompt 'Entrer un numéro de collection'
accept vnbessai prompt 'Entrer un nombre dessai'
accept vtemps_max prompt 'Entrer un temps maximum'
Begin
    inserer_niveau(&vidniveau , &vcollection, &vnbessai, &vtemps_max);
End;
/

-- Procédure pour insérer un nouveau joueur
create or replace procedure inserer_joueur(
    vidJoueur Joueur.idJoueur%type,
    vmdp Joueur.mdp%type, 
    vniveau_max Joueur.niveau_max%type
--    pretour OUT number
) AS
    exception_mdp exception;
    pragma exception_init(exception_mdp, -02290);
begin
    insert into Joueur values (vidJoueur, vmdp, vniveau_max);
    commit;
--    pretour := 0;
Exception
    When Dup_val_on_index Then
        DBMS_OUTPUT.PUT_LINE('le joueur éxiste déjà ');
--        pretour := 1;
    when exception_mdp then
        DBMS_OUTPUT.PUT_LINE('Le mot de passe doit etre entre 6 et 15 caractères');
--        pretour := 2;
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || sqlerrm);
--        pretour := 3;
End;
/

accept vidJoueur prompt 'Entrer un identifiant de joueur'
accept vmdp  prompt 'Entrer un mot de passe'
accept vniveau_max prompt 'Entrer un niveau max'
Begin
    inserer_joueur('&vidJoueur', '&vmdp', &vniveau_max);
End;
/

-- Procédure pour insérer une nouvelle Partie
create or replace procedure inserer_Partie(
    vidPartie Partie.idPartie%type,
    vidJoueur Partie.idJoueur%type, 
    vmot Partie.mot%type,
    vidNiveau Partie.idNiveau%type,
    vheure Partie.heure%type
--    pretour OUT number
) AS
    pidJoueur Partie.idJoueur%type; 
    pmot Partie.mot%type;
    pidNiveau Partie.idNiveau%type;
    exception_foreign exception;
    i int:=0;
    pragma exception_init(exception_foreign, -02291);
begin
    select idJoueur into pidJoueur
    from Joueur
    where idJoueur = vidJoueur;
    i := 1;
    select mot into pmot
    from dico
    where mot = vmot;
    i := 2;
    select idNiveau into pidNiveau
    from Niveau
    where idNiveau = vidNiveau;
    i := 3;
    insert into Partie (idPartie, idJoueur, mot, idNiveau, heure)
    values (vidPartie, 'vidJoueur', 'vmot', vidNiveau, vheure);
    commit;
--    pretour := 0;
Exception
    When Dup_val_on_index Then
        DBMS_OUTPUT.PUT_LINE('la partie éxiste déjà ');
--        pretour := 1;
    when exception_foreign then
        DBMS_OUTPUT.PUT_LINE('Non respect dune clé etrangère');
--        pretour := 2;
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || sqlerrm);
--        pretour := 3;
End;
/
accept vidPartie prompt 'Entrer une nouvelle partie de joueur'
accept vidJoueur prompt 'Entrer un identifiant de joueur'
accept vmot  prompt 'Entrer un mot'
accept vidNiveau prompt 'Entrer un niveau'
accept vheure prompt 'Entrer une heure de début'
Begin
    inserer_Partie(&vidPartie, '&vidJoueur', '&vmot', &vidNiveau, &vheure);
End;
/

-- Procédure pour insérer une nouvelle Mémoire
create or replace procedure inserer_memoire(
    vidEssai Memoire.idEssai%type,
    vidPartie Memoire.idPartie%type,
    vchaine Memoire.chaine%type,
    vposition Memoire.position_essai%type
--    pretour OUT number
) AS
    exception_foreign exception;
    pragma exception_init(exception_foreign, -02291);
begin
    insert into Memoire values (vidEssai, vidPartie, 'vchaine', vposition);
    commit;
--    pretour := 0;
Exception
    When Dup_val_on_index Then
        DBMS_OUTPUT.PUT_LINE('lessai existe déjà ');
--        pretour := 1;
    when exception_foreign then
        DBMS_OUTPUT.PUT_LINE('La partie nexiste pas');
--        pretour := 2;
    when others then
        DBMS_OUTPUT.PUT_LINE(sqlcode || sqlerrm);
--        pretour := 3;
End;
/

accept vidEssai prompt 'Entrer un nouvel essai'
accept vidPartie prompt 'Entrer une nouvelle partie de joueur'
accept vchaine prompt 'Entrer une chaine'
accept vposition prompt 'Entrer une position'
Begin
    inserer_memoire(&vidEssai, &vidPartie, '&vchaine', &vposition);
End;
/

-- Procédure pour modifier partie
create or replace procedure modif_partie(
    vidPartie Partie.idPartie%type,
    vidNiveau Partie.idNiveau%type,
    vtemps Partie.temps%type
--    pretour OUT number
) AS
    vscore Partie.score%type;
    pessai int; 
    exception_foreign exception;
    pragma exception_init(exception_foreign, -02291);
begin
    select count(id_essai) into pessai
    from memoire
    where idPartie=vidPartie;
    select ((temps_max - vtemps) * 2 + (nb_essai - pessai) * 100) into vscore
    from niveau
    where idNiveau=vidNiveau;
    
    update Partie
    set temps=vtemps, score=vscore
    where idPartie=vidPartie;
    commit;
--    pretour := 0;
End;
/
accept vidPartie prompt 'Entrer la partie a modifier'
accept vidNiveau prompt 'Entrer le niveau de la partie a modifier'
accept vheure prompt 'Entrer un temps de jeu'
Begin
    modif_partie(&vidPartie, &vidNiveau, &vtemps);
End;
/






-- Triggers
-- Blocage des niveaux en fonction de l'expérience
create or replace trigger t_b_i_Partie
before insert on Partie
declare
    vniveau_max joueur.niveau_max%type;
    vnb_parties int;
    tretour number out;
begin
    select niveau_max into vniveau_max
    from joueur j
    where p.idJoueur = j.idJoueur;
    select count(idPartie)into vnb_partie
    from partie
    where :new.heure > heure - 1 and score = 0;
    if(vniveau_max < :new.niveau) then
        raise application_error(-20001, 'Le joueur ne peut pas accéder à ce niveau');
        tretour := 1;
    elsif(vnb_partie > 5) then
        raise application_error(-20002, 'Le joueur a perdu plus de 5 parties dans la dernière heure');
        tretour := 2;
    end if;
end;
/

create or replace trigger t_a_u_Partie
after update on Partie
declare
    vnb_gagne int;
    vniveau_max int;
    vniveau_max_joueur int;
    tretour number out;
begin
    select count(idPartie) into vnb_gagne
    from Partie p, Joueur j
    where p.idJoueur = j.idJoueur and p.idNiveau = j.niveau_max and p.score > 0;
    select max(idNiveau) into vniveau_max
    from niveau;
    select niveau_max into vniveau_max_joueur
    from joueur j, partie p
    where p.idJoueur = j.idJoueur;
    if(vnb_gagne > 5 and vniveau_max_joueur < vniveau_max) then
        update joueur
        set niveau_max = niveau_max + 1
        where ;
    end if;
end;
/