---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2012-05-30T16:44:47Z
tags: maven bash
title: Maven project starter
url: /2012/05/30/maven-project-starter/
---

Parfois commencer un project c'est long et embêtant car il faut commencer par créer la structure du project selon maven. Comment peut-on le faire rapidement?

Aujourd'hui, on utilise beaucoup maven dans le développement, surtout
web, mais commencer la phase de dev d'un projet peut être un peu long.

Il faut toujours passer par la phase de création des dossiers
conventionnés par maven et ce n'est pas toujours simple. Alors astuce :

{{< highlight powershell >}}
function create-maven-struct(){
  local base=$1
  [ "$base" == "" ] && base="."
  mkdir -p $base/src/{main,test}/{java,resources}
}
{{< / highlight >}}

Ajoutez cette fonction dans votre `~/.bashrc` ou équivalent et vous
serez en mesure de créer la structure d'un projet maven très simplement
grâce à la fonction `create-maven-struct`.

A noter que sans argument, la structure sera créée dans le dossier
courant, et avec argument la structure sera créée à partir de
l'argument (également créé s'il n'existe pas).

Enjoy :)
