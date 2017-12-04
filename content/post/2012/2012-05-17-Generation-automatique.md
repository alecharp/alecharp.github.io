---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2012-05-17T18:05:12Z
tags: jekyll git
title: Génération automatique avec jekill, git / github et apache
url: /2012/05/17/Generation-automatique/
---

Passer de wordpress à Jekyll, ça peut faire peur pour la mise en ligne de nouveaux posts. Heureusement, certains outils et une légère configuration permettent de passer outre ce soucis.

Alors ce n'est pas parce que j'ai choisi de passer sur Jekyll que j'ai
envie de tout refaire à la main. Par exemple, je n'ai pas envie de devoir
regénérer le site web à chaque fois que j'écris un nouvel article.

Pour faire ça, ce n'est pas très compliqué avec le bon combo d'outils :
**git** + **github** + **apache - cgi**

<div class="alert alert-info">Je ne vais pas mettre les chemins d'accès
disque dans l'article car je suis un peu timide...</div>

## Script bash de génération avec jekyll
On commence par mettre en place un script qui permettra de récupérer les
derniers articles publiés et générer les pages statiques.

Le choix de git et github se fait alors comprendre : simple, efficace, et
versionner des textes c'est après tout ce que git fait de mieux. Donc des
posts en *markdown* ça se comprend aussi.

{{< highlight PowerShell >}}
#!/bin/sh

echo -e "Content-type:text/plain\n\n"
#Entête http nécessaire pour que le script soit correctement exécuté

git_dir="/path/to/git/clone"
site_dir="/path/to/virtualhost/location"

cd ${git_dir}
git fetch origin
git checkout master
git merge origin/master

jekyll ${git_dir} ${site_dir} 2>&1
{{< / highlight >}}

Ici on part du principe que le clone est déjà effectué mais on pourrait
très bien rajouter quelques lignes pour le faire s'il n'existe pas:

{{< highlight PowerShell >}}
...
if [ ! -d ${git_dir}/.git ]; then
  git clone git@github.com:user/repository ${git_dir}
fi
...
{{< / highlight >}}

Une fois l'exécution du script autorisée (`chmod a+x /path/to/script`),
essayez de l'exécuter vous-même.

## Exécuter le script via une URL
Pour ça, j'ai besoin du module cgi de Apache. Parce que j'héberge d'autres
sites internet utilisant wordpress, j'utilise un serveur httpd Apache. Je
vais l'utiliser pour ne pas multiplier les outils pour faire la même chose.

Donc dans la configuration de votre Apache (ou virtualhost), il suffit
de mettre en place la directive `ScriptAlias` vers le dossier contenant
le script que l'on a écrit juste avant.

{{< highlight apache >}}
<VirtualHost *:80>
  ServerName name.extension
  DocumentRoot /path/to/site/folder
  ScriptAlias /name-that-you-choose/ /path/to/scripts/folder
</VirtualHost>
{{< / highlight >}}

Après avoir redémarré le service Apache (`/etc/init.d/apache2 restart`),
vous pouvez essayer l'URL *http://name.extension/name-that-you-choose/script-name*
qui doit exécuter le script.

<div class="alert alert-warn">J'ai un peu lutté sur cette partie pour la
simple raison que l'utilisateur qui exécute le script dans le process du
serveur web n'avait ni python ni pygmentize dans son path. De ce fait,
la génération de rendait pas des pages correctes.</div>


## Configuration de Github.com
On configure maintenant github pour qu'à la réception d'un push, il sollicite
une URL, l'URL du script configuré ci-dessus.

Dans la partie administration de votre repository, vous pouvez configurer
des hooks dans la partie **Service Hooks** (*https://github.com/user/repository/admin/hooks*).
Le hook que l'on souhaite mettre en place est le premier : *Webhook URLs*
qui enverra une requête POST http sur l'URL en question. Mettez l'URL d'
accès à votre script (*http://name.extension/name-that-you-choose/script-name*),
sauvegardez et vous pouvez ensuite l'essayer.

## Conclusion
Avec cette configuration, je me contente de mettre en place sur la branche
master les articles que je souhaite publier. Ceci ne m'empêche pas de
travailler sur plusieurs branches (une par article par exemple) mais me
permet de m'assurer que la publication d'article n'est faite que sur la
branche master. Il suffit de merger ou rebaser les articles dans master
puis de pusher master sur github pour que le site soit généré à nouveau
grâce au script.

Il y a plein de moyens pour publier votre site généré avec Jekyll. Je n'ai
peut-être pas choisi la plus simple mais celle qui me convient le mieux.
Une autre solution envisageable selon moi est celle de tâches dans un
`Rakefile` : l'une pour la génération du site en local, l'autre pour faire
un rsync du site local (`_site`) vers le *DocumentRoot* de votre serveur
Apache (via ssh ou file). Mais là encore, il faudrait effectuer des tâches
sur ma machine pour la génération. Avec ma solution, on pourrait imaginer
écrire un article sur un mobile, ou sur un ordinateur d'un ami (pas les
clés ssh pour pusher sur github) et n'avoir qu'à uploader à la main sur
la branche master le fichier de l'article via l'interface web de github.
Alors la publication se ferait toute seule.

## Nota Bene
À force d'écrire des articles (non je ne les ai pas tous publiés), j'ai
créé une task dans un `Rakefile` pour créer la structure du fichier d'un
article automatique. Ainsi, je commence plus vite un article. C'est pas
pour ça que je les écris mieux, plus vite ou avec moins de fautes me
direz-vous.
