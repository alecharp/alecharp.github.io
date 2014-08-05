---
layout: post
date: 2013-07-05 18:00:00
author:
  name: Adrien Lecharpentier
  email: adrien.lecharpentier@gmail.com
title: Maven, The evil
---
Maven ou le cauchemar des nomades à faible mémoire

Maven, c'est bien:

 - ça va chercher les dépendances, on ne sait pas où mais on veut surtout par savoir,
 - ça les mets dans le classpath qui va bien lors du run (compile, test, runtime), 

Mais maven, c'est le mal!

## Les dépendances

Lorsque l'on souhaite utiliser une librairie, on l'ajoute dans le `pom.xml` de notre projet et maven s'occupe d'aller la trouver, de la télécharger et de nous la mettre à disposition.

> Pour rappel, maven télécharge la dépendance dans le dossier $M3_HOME/repository ou `local.repository` défini dans votre `$M3_HOME/conf/settings.xml`.

Simple. Efficace. À toutes épreuves.

Pas vraiment.

## L'espace disque

Une fois de temps en temps, vous pouvez être amené à vouloir supprimer votre repository local, ceci afin de grappiller quelques Mo (ou Go dans mon cas). Oui oui quelques Giga-octet.

Donc vous n'avez plus aucune dépendance. Pas un soucis, à votre prochaine commande `mvn compile`, maven se charge de recharger toutes vos dépendances.

## Les dépendances, le retour

Toutes? **NON** ! Uniquement celle du projet courant!

On peut se dire

> Oui, c'est normal, comment veut-tu qu'il connaissent toutes les dépendances dont tu a besoin?

ou

> Bah, tu crois quoi? Le cerveau il est sensé être entre le clavier et la chaise, pas ailleurs!!

Oui oui tout ça c'est bien vrai. Mais parfois j'oublie..

## Conséquence

J'ai un repository complet pour les projets sur lesquelles je travaille en journée ou que j'ai ouvert récemment. 

Pour les autres, dont celui que je me gardais pour mes 2h30 de train, et bien non. J'ai aucune dépendance nécessaire..

Donc au lieu de coder bien sagement dans le train, j'écris ces quelques lignes..

Bien à vous.