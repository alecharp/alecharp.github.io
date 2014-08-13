---
layout: post
title: OSX Mountain Lion, SVN et unicode
date: 2012-09-05  0:30:59
author:
  name: Adrien Lecharpentier
  email: adrien.lecharpentier@gmail.com
tags: misc mac brew install svn unicode
---
Utiliser Subversion sur un Mac avec support des chemins unicodes

Dans l'univers impitoyable de Mac OS, je demande le support de l'unicode sur
Subversion.

Bien que le langage majoritairement utilisé dans le monde de l'informatique
soit l'Anglais, il y a quelques irréductibles (_gaullois_?) qui ne souhaitent
pas utiliser la langue de Shakespeare dans certains cas. Ce n'est pas trop un
soucis quand il s'agit de textes anciens ou de codes sources, mais le problème
est plus grand quand cela s'applique également aux noms des fichiers.

## Mise en condition
Dans le cadre de l'exemple, nous allons dire que vous préparez un petit talk
pour faire la démonstration de votre toute dernière acquisition informatique :
un ventilateur USB !

Vous avez un compte chez un hébergeur de service SVN et donc vous utilisez
celui-ci pour hoster votre présentation au format otp[*].

Vous faites donc votre checkout, vous créez votre fichier (vide pour le
moment) puis vous faites un `svn add démonstration.otp` ainsi qu'un `svn
commit -m "Initial import, empty file"`.

On s'attend alors à avoir un status clean :

{% highlight PowerShell %}
$ svn status
$
{% endhighlight %}

Mais là, Ô malheur, nous avons :

{% highlight PowerShell %}
$ svn status
? démonstration.otp
! démonstration.otp
{% endhighlight %}

Oui mais encore ?

## Unicode
Donc on ne cherche pas encore midi à 14 heures et on mise tout sur l'accent
dans le nom du fichier. Donc un petit `locale` s'impose :

{% highlight PowerShell %}
$ locale
LANG="fr_FR.UTF-8"
LC_COLLATE="fr_FR.UTF-8"
LC_CTYPE="fr_FR.UTF-8"
LC_MESSAGES="fr_FR.UTF-8"
LC_MONETARY="fr_FR.UTF-8"
LC_NUMERIC="fr_FR.UTF-8"
LC_TIME="fr_FR.UTF-8"
LC_ALL=
{% endhighlight %}

D'accord très bien, UTF-8 c'est propre, pas de soucis. Mais les accents ne sont
pas codés pareil.

Allons faire un tour du côté de l'installation de subversion avec `brew`:

{% highlight PowerShell %}
$ brew info subversion
…
==> Options
--python
	Build Python bindings
--universal
	Build a universal binary
--ruby
	Build Ruby bindings
--perl
	Build Perl bindings
--unicode-path
	Include support for OS X UTF-8-MAC filename
--java
	Build Java bindings
{% endhighlight %}

C'est parfait, on peut faire l'installation avec le support de l'unicode sur les
noms de fichiers donc problème résolu.

{% highlight PowerShell %}
$ brew uninstall subversion
…
$ brew install subversion --unicode-path
…
{% endhighlight %}

## Ça ne fonctionne toujours pas ?
Là c'est entièrement de ma faute : pas la bonne commande de svn... `brew`
installe les commandes dans `/usr/local/bin` mais la commande que j'utilisais
était dans `/usr/bin` donc pas la bonne. Modification du `PATH` pour que
`/usr/local/bin` soit avant `/usr/bin` et le tour est joué.

*: 2 problèmes déjà, SVN et fichier binaire donc on oublie les diffs et les
merges !

## Edit
On me fait signe de la main que le problème vient tout simplement du choix
d'implémetation de l'UTF-8 par MacOS qui est différent de Linux et Windows (qui
eux ont la même).

Et petite chose encore, j'ai voulu, pour satisfaire ma fainéantise, installer
un client graphique (svnX0 pour gérer ma copie du repository. Mauvaise idée :
certains (oui certains, pas tous) fichiers sont retournés dans l'état "non
synchronisé - manquant" du début de l'article. Je sens que la guerre de l'UTF-8
est loin d'être finie.
