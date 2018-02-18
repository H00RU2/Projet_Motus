drop table Memoire;
drop table Partie;
drop table Dico;
drop table Niveau;
drop table Collection;
drop table Joueur;

create table Joueur(
  idJoueur varchar(20),
  mdp varchar(20),
  niveau_max int,
  constraint pk_idJoueur primary key (idJoueur),
  constraint ck_mdp check (5 < length(mdp) and length(mdp) < 16));
  
create table Collection(
  idCollection int,
  constraint pk_idCollection primary key (idCollection),
  constraint ck_Collection check (0 < idCollection and idCollection < 6));
  
create table Dico(
  Mot varchar(20),
  idCollection int,
  constraint pk_Mot primary key (Mot),
  constraint fk_idCollection foreign key (idCollection) references Collection(idCollection),
  constraint ck_mot check (4 < length(mot) and length(mot) < 10));
  
create table Niveau(
  idNiveau int,
  idCollection int,
  nb_essai int,
  temps_max int,
  constraint pk_idNiveau primary key (idNiveau),
  constraint fk_idCollection2 foreign key (idCollection) references Collection(idCollection),
  constraint ck_nb_essai check (4 < nb_essai and nb_essai < 11));
  
create table Partie(
  idPartie int,
  idJoueur varchar(20),
  Mot varchar(20),
  idNiveau int,
  heure date,
  temps int,
  score int constraint nn_score not null,
  constraint pk_idPartie primary key (idPartie),
  constraint fk_idJoueur foreign key (idJoueur) references Joueur(idJoueur),
  constraint fk_idNiveau foreign key (idNiveau) references Niveau(idNiveau),
  constraint fk_Mot foreign key (Mot) references Dico(Mot));
  
create table Memoire(
  idEssai int,
  idPartie int,
  chaine varchar(20),
  position_essai int,
  constraint pk_idEssai primary key (idEssai),
  constraint fk_idPartie foreign key (idPartie) references Partie(idPartie));
