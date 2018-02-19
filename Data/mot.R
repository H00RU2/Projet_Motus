setwd("D:/Projet_Motus/Data")

liste <- read.table("liste_francais.txt", header=T, sep="\t", encoding = "UTF-8")
summary(liste)

liste2 <- 4 < liste[length(liste$X1_graph)]
