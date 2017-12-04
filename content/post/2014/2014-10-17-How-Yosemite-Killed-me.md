---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
banner: /images/2014-10-17-How-Yosemite-Killed-me/banner.jpg
date: 2014-10-17T00:00:00Z
tags: osx java
title: Comment Yosemite m'a tué
url: /2014/10/17/How-Yosemite-Killed-me/
---

Sur un élan de motivations, j'ai mis à jour ma version d'OSX aujourd'hui.. L'erreur bête!

## Mise à jour

Évidemment, j'ai commencé par voir une nouvelle version de OSX: Yosemite. Je regarde 2-3 liens pour voir les améliorations. Je n'en trouve pas tellement. J'aurai dû m'arrêter là, mais non.

Je décide quand même de faire la montée de version. Pas très compliqué: __AppStore >> Yosemite >> Télécharger__. Chanceux je suis, je le fais sur une fibre optique, du coup, 20min et c'est réglé.

## Le début des problèmes

Une fois téléchargée, je procède à la mise à jour. *Clic*, *Clic*, ça suit son court. L'affichage me dit "Il reste 18 minutes". Parfait, je reste devant. 3 minutes plus tard, toujours 18 minutes restantes. Bon ok, je vais prendre un café. Je remonte quelques minutes plus tards : "17 minutes". Ça doit être les minutes spéciales Apple. Il est presque l'heure de manger, j'initie donc le mouvement.

Après manger, soit 1h environ, "Il reste environ 2 minutes". Mouais, j'y crois moyen. Je fais donc d'autres recherches en espérant qu'il n'y a pas que moi dans la mouïse.. Je découvre

{{< highlight bash >}}
Cmd + L
{{< / highlight >}}

pour ouvrir le fichier de log et s'assurer qu'il se passe bien des choses.. Bon il y a bien du mouvement, je m'impatiente mais je suis moins inquiet.

## La fin ? non..

Ce n'est qu'une heure plus tard que j'ai récupéré mon ordinateur. Après un bref coup de stress lors de l'apparition d'une fênetre "Installation en cours" et "Il reste environ 8 minutes" après un redémarrage. Mais cette fois c'était bon.

Je fais un peu le tour du propriétaire, un petit

{{< highlight bash >}}
~> brew doctor
Error: No such file or directory - /Library/Developer/CommandLineTools/usr/bin/clang
{{< / highlight >}}

Et là c'est le drame.. Malheureusement, le problème n'est pas terminé. Pire:

![](/images/2014-10-17-How-Yosemite-Killed-me/java6-for-IJ.png)

## J'enrage

Pour une monté de version qui ne semble apporter que des changement visuels, je trouve que casser mon environnement c'est pas super sympa.. De quoi avoir envie de repasser sur une Arch ou même Ubuntu..

Non peut-être pas jusqu'à une Ubuntu.. Mais il va falloir que je règle ce problème rapidement maintenant.
