---
layout: post
date: 2013-10-22 18:00:00
author: adrien.lecharpentier@gmail.com
title: ngParis chez Google
excerpt: Retour sur cette soirée AngularJS
---

> Disclamer: J'essaye de retranscrire ce que j'ai compris, entendu de la soirée ainsi que mon ressenti. Les avis, points de vue me sont propre et pourrait ne pas refléter l'intégralité du message que les personnes présentes ont souhaité faire passer.

Hier soir, chez Google France, était donné le rendez-vous pour le dernier [meet-up AngularJS][meetup] en date. Le programme annoncé était lourd, avec de bons speakers: 

 - JQuery et AngularJS par Pawel Kozlowski ([@pkozlowski_os][pkozlowski_os_twitter])
 - Les services par Thierry Chatel ([@ThierryChatel][ThierryChatel_twitter])
 - Les scopes isolés par Thierry Chatel ([@ThierryChatel][ThierryChatel_twitter])

[meetup]: [http://www.meetup.com/AngularJS-Paris/events/136250782/](http://www.meetup.com/AngularJS-Paris/events/136250782/)
[pkozlowski_os_twitter]: https://twitter.com/pkozlowski_os
[ThierryChatel_twitter]: https://twitter.com/ThierryChatel

Pour un programme pareil, il ne fallait pas moins que Google pour accueillir tout le monde. Vraiment tout le monde car pour un évènement d'une soirée, 250 places c'est plutôt pas mal. Mais avec ce programme, les places sont vites parties.

## Organisation

Début de l'évènement à 19h (annoncé), les participants commencent à se regrouper à partir de 18h30 devant la grille, ouverture à 18h45. Alexis Moussine-Pouchkine ([@alexismp][alexismp_twitter]) fait l'entrée, Thierry Lau ([@laut3rry][thierrylau_twitter]) et Sébastien Letélié ([@sebmade][sebastienletelie_twitter]) font la distribution des t-shirts et badges. Tout le monde est assis avec t-shirt, badge et sticker à 19h15. Un mot: efficace!

[alexismp_twitter]: https://twitter.com/alexismp
[thierrylau_twitter]: https://twitter.com/laut3rry
[sebastienletelie_twitter]: https://twitter.com/sebmade/

Les locaux sont magnifiques, 2 vidéo-projections sont prévues pour la salle, les micros sont ouverts: il est temps de faire les premières annonces, la présentation (si besoin est) du premier speaker de la soirée.

## JQuery et AngularJS philosophie

### Présentation de Pawel Kozlowski

Pawel se définit comme un "open-source enthousiast". On le retrouve sur [twitter][pkozlowski_os_twitter], sur [github][pkozlowski_os_github] ainsi que sur son [blog][pkozlowski_os_blog]. Il est également l'auteur du livre [Mastering Web Application Development with AngularJS](http://www.packtpub.com/angularjs-web-application-development/book?utm_source=author-links&utm_medium=author-links&utm_campaign=author-links).

[pkozlowski_os_github]: https://github.com/pkozlowski-opensource
[pkozlowski_os_blog]: http://pkozlowskios.wordpress.com/

### Talk

Pawel commence par un:

> "It is not how JQuery is bad, on the contrary, but how to do without it"

On comprend donc que l'on ne va pas voir de "magie" JQuery. Tant mieux. 

Le conseil suivant s'adresse particulièrement au débutant AngularJS:

> "Do not use AngularJS with JQuery in your application."

Si on regarde la documentation, on voit que AngularJS utilisera JQuery si celui-ci est disponible sinon il utilisera une implémentation interne, une sorte de JQLite. Le conseil de Pawel n'est pas contraire à la doc, mais il précognise seulement de ne pas avoir la possibilité de ce service de JQuery dans le code et donc d'adopter la philosophie AngularJS dès le début.

Car le problème se pose bien là. Le développement avec JQuery et AngularJS est vraiment différent et les mélanger n'est pas forcément une bonne option.

#### Impératif vs Déclaratif

Le développement avec JQuery est impératif, contrairement à AngularJS qui est déclaratif. 

Avec JQuery, vous développez en pas à pas, vous avez le contrôle sur ce qui se passe sur le DOM.

Avec AngularJS, vous décrivez ce que vous voulez et laissez le soin à AngularJS de produire le résultat attendu.

#### Size doesn't matter they say

Bon sous un titre accrocheur, je vais simplement revenir sur les exemples que Pawel nous a donné pour nous prouver que mélanger JQuery et AngularJS n'est pas une bonne option.

Le premier exemple de Pawel, c'est un composant "twitter-like":

 - une textbox,
 - un bouton "tweet",
 - un bouton clear,
 - un indicateur du nombre de caractères restants,
 - la liste des "tweets".

Tous les éléments sont pilotés par l'état de la textbox. 

Nous avons donc deux façons de réaliser cet exemple: JQuery ou AngularJS.

Avec JQuery, une méthode centrale, en mode listener, va modifier la classe et l'état des boutons. Le code est long et touche au DOM à base de `$("#id").text()` etc. 

Avec AngularJS, les boutons se modifient eux-même (directives) avec les valeurs du modèle. On ne touche pas au DOM dans le modèle, on ne touche pas au modèle directement dans le HTML. On divise pour régner. Ce à quoi il nous dit:

> "If you do DOM manipulation in controllers, unicorns are dying!"

C'est surtout qu'agir de la sorte, c'est passer à côté d'AngularJS.

Autre exemple, bootstrap-paginator. Le plugin utilise JQuery et manipule le DOM dans le code: +600 lignes de code. Même comportement en AngularJS pure (par Pawel): <50 lignes. En plus, on externalise en DOM (template) ce qui simplifie la modification future si souhaitée. 

#### Enrober du code JQuery dans une directive

Dans un soucis de ne pas ré-inventer la roue, nous pourrions donc vouloir mettre le code de certains plugins JQuery (datepicker par exemple) dans une directive AngularJS.

Là encore, ce n'est pas une bonne idée. Le cas de "typehead" est flagrant : les valeurs possibles sont récupérées via un service ou autre mais doivent être accessibles au plugin. Il faudrait donc à la fin de la compilation de la page activer le plugin. Ce qui n'a pas de sens pour AngularJS car la page _peut_ changer tout le temps, car le modèle peut rapporter de nouvelles valeurs.

#### JQuery a encore sa place

Toutefois, JQuery est loin d'être inutile. Il est nécessaire pour tester l'emplacement du DOM, pour positionner des éléments, entre autres.

#### Conclusion

La syntaxe est simple, vous pouvez toujours tout réécrire, réutiliser le code JQuery ou les plugins AngularJS.

AngularJS est une nouvelle approche du développement front et pour bien comprendre le développement et la philosophie d'e 'AngularJS, il est préférable de ne pas avoir JQuery dans son application pour commencer. Toutefois, JQuery est très utile pour maitriser son DOM.

### Fin du talk

Le premier talk est terminé, il est bien accueilli. Quelques questions sont posées sur la séparation du DOM / model, pourquoi ne pas avoir utilisé JQuery comme fondation (de la part d'un commiter EmberJS).

Bref, un bon point sur de bonnes pratiques, un point de vue assez tranché avec tout de même une vision réaliste sur le développement actuel. Bravo et Merci à Pawel pour sa prestation. 

Une petite photo pour immortaliser l'assemblée (avec les tshirts offerts) et au suivant: Thierry Chatel.

## Les services dans AngularJS

### Présentation de Thierry Chatel

Thierry est un consultant indépendant et formateur. Depuis quelques mois, il ne fait presque que de la formation AngularJS. Après un tour de France des conf avec Sébastien Letélié, il vient nous parler à Paris. Il est derrière le site [FrAngular](http://www.frangular.fr).

### Talk

On annonce directement la couleur: 

> "90% du code de l'application [front] doit se trouver dans des services".

Basiquement, le service est une étiquette vers un singleton. Nous aurons donc toujours la même instance d'un objet ou une copie de la valeur primitive contenu dans le service (différence dûe au fonctionnement de JavaScript).

Thierry nous parle de 5 règles à appliquer avec AngularJS:

 1. de code métier, point tu mettras dans ton controller &rarr; service
 1. dans le doute, un service tu feras
 1. si un service tu ne peux pas utiliser, un service il te faudra écrire
 1. si tu crois qu'un service tu ne peux pas utilser, un service tu utiliseras
 1. dans les autres cas, un service tu feras

Il nous a montré que c'est un principe déjà très utilisé dans AngularJS même: $http / $httpBackend, $route / $location. Bref sans s'en rendre compte, nous le voyons déjà et malgré tout je m'apperçois que je ne l'applique pas. En 10min de discours, il me faut repenser à beaucoup de lignes de code que j'ai écrite, dans mon DOM ou mon controller: conditions d'affichage, conditions d'activations, etc.

Je n'ai malheureusement pas pris beaucoup de notes car la fatigue et la faim arrivaient. Cependant, c'était vraiment très intéressant, j'ai donc écouté. En reprenant des notes, j'aurai perdu le fil et donc pas pu saisir le sens de la présentation: faire du Service votre allié.

## Les scopes isolés

Du même speaker, nous voyons maintenant l'utilisation de scope isolé, ce que ça apporte, quand et comment l'utiliser. 

> Disclamer: toujours très peu de notes, toutes mes excuses.

On commence par un rappel sur le scope: les scopes (classique) héritent du scope attaché au DOM parent dans le HTML

    <div ng-app="App">
        <div ng-controller="FirstCtrl">
            <div ng-init="test=true"></div>
        </div>
        <div ng-view></div>
        <div ng-controller="FooterCtrl"></div>
    </div>

donne

    - scope application
        + scope FirstCtrl
            + scope 
        + scope view
        + scope FooterCtrl

Si une propriété n'est pas disponible dans le scope courant, on va la chercher dans le scope parent et ainsi de suite.

L'isolation de scope est un principe pour l'écriture de Directive. Cela va permettre de bien séparer les données entre votre application et votre directive.

Cependant, toute les directives ne doivent pas avoir de scope isolé: si le template contient un autre template, alors le scope de la première directive ne doit surtout pas être isolé.

## Conclusion

Je sais que j'ai été plus que rapide sur les 2 dernières présentations. Cela ne reflette en rien la qualité de celle-ci. J'ai dû faire un choix: suivre, comprendre et apprendre ou prendre des notes. 

Toutefois, la bonne nouvelle c'est que la conférence a été filmé et sera prochainement mise en ligne (merci les services techniques de Google!). Les slides seront sûrement publiés dans peu de temps. 

Pour ma part, j'ai pris un grand plaisir à assister à cette conférence. Une très belle organisation, des locaux magnifiques, non pas un mais 3 buffets à disposition pour se restaurer. Les speakers très intéressants, du code, des retours d'expériences et des bonnes pratiques. Pour moi, une combinaison parfaite.

Un grand bravo aux organisateurs et à bientôt!

## Annonce de fin

Sébastien Letélié nous rappelle qu'il organise un hackaton dédié à la santé les 28-29-30 mars prochain à Strasbourg. Les défis provenant des médecins arriveront bientôt. Il peut s'agir d'une bonne occasion de mettre en oeuvre AngularJS dans le cadre d'un projet. Plus d'informations sur le site [http://digitalhealthcamp.eu/](http://digitalhealthcamp.eu/).
