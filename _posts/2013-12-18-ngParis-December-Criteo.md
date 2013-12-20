---
layout: post
date: 2013-12-19 19:00:00
author: adrien.lecharpentier@gmail.com
title: ngParis chez Criteo
excerpt: Retour sur ce 6ième évènement ngParis
---

> Disclamer: J'essaye de retranscrire ce que j'ai compris, entendu de la soirée ainsi que mon ressenti. Les avis, points de vue me sont propre et pourrait ne pas refléter l'intégralité du message que les personnes présentes ont souhaité faire passer.

Nous revoilà sur une soirée ngParis. Une fois de plus, la soirée est rempli (170 Angularians et 103 sur liste d'attente) bien avant la soirée. Cependant, nous n'étions pas une 50aine dans la salle. Dommange, Criteo avait prévu pas mal de pizza / boisson pour la pause. Personnenllement, n'ayant pas pu me rendre à la [soirée #5 chez Deezer][meetup#5], je me suis inscrit pour cette #6 le soir même de la #5. 

[meetup#5]: http://www.meetup.com/AngularJS-Paris/events/147070122

Pour cette fin d'année, nous sommes chez Criteo et 2 talks sont prévus au programme:

 - Présentation et retour d'expérience sur W20 par __Adrien Lauer__ ([@adrienlauer][adrien_twitter])
 - Les `promises`, par __Chakib Benziane__ ([@sp4ke][chakib_twitter])

[adrien_twitter]: https://twitter.com/adrienlauer
[chakib_twitter]: https://twitter.com/sp4ke

## Organisation

Ce soir, nous sommes chez Criteo. On commence donc par une petite présentation de la société de publicité ciblé sur le web. Fabrice Destagnol, directeur créatif, nous souhaite la bienvenue, signale la présence de certains autres Criteo-siens dans la salle et de la volonté de recrutement de la société.

La salle est sympa, mode amphi-théâtre, mais les speakers ont eu pas mal de soucis à cause d'un connecteur VGA manquant.

## W20

### Adrien Lauer

Adrien travaille pour PSA dans un équipe tranverse. Ils proposent (ou plus) aux équipes de développement des outils, framework et les bonnes pratiques qui vont avec. C'est dans ce cadre qu'ils ont regardé AngularJS il y a un peu plus d'un an. Afin de garantir la bonne utilisation ainsi que la compréhension de l'outil, ils ont construit un framework front autour de AngularJS et RequireJS.

Vous pouvez les trouver sur Twitter ([@adrienlauer][adrien_twitter]) et Github ([adrienlauer][adrien_github]).

[adrien_github]: https://github.com/adrienlauer

### Le framework

Derrière cette formule chimique se cache en réalité un framework front construit autour d'AngularJS et RequireJS pour PSA. Ce framework a été conçu pour permettre la création rapide de nouveau projet ainsi que de garder une structuration bien définie des projets. 

Une bonne chose à savoir: il y avait un framework, vieux de 7ans chez PSA, fait pour cacher le JS et le front en général aux développeurs interne. Ce framework est devenu trop vieillissant et peu propise aux nouvelles fonctionnalités. Donc, bien partir, petit tour des framework front il y a un peu plus d'un an. Angular a retenu l'attention pour la simplicité sûrement.

### Vocabulaire

Le framework apporte une nouvelle appélation: les fragments pour des morceaux de codes réutilisable. Un peu à la mode des modules / artefacts Maven. La comparaison m'est douloureuse mais étant donné qu'ils utilisent Maven / Archiva pour partager ces fragments entres applications, je ne peux pas faire autrement. 

### Utilisation

Pour l'utilisation, cela semble assez simple: un fichier json pour appeler les fragments à utiliser avec une configuration particulière:

    {
        "../../../w20/w20-core/w20-core.w20.json" : {
            "modules" : {
                "application":{
                    "id":"w20-hello-sample",
                    "home":"/hello"
                }
            }
        },
        "": {
            "routes": {
                "/hello":{
                    "template":"<h1>Hello World !</h1>"
                }
            }
        }
    }

On définit ici une application "w20-hello-sample", avec pour page d'accueil "/hello". Ceci donnera l'équivalent de la configuration de `$routeProvider` avec un `when` et `otherwise`. On voit donc que la configuration est beaucoup plus abbrégé.

Pour que cela fonctionne on appelle dans notre html le framwork W20:

    <script
            type="text/javascript"
            data-main="../../../w20/w20-core/w20"
            src="../../../w20/w20-core/libext/requirejs/require.js">
    </script>

On voit passer les logs du framework qui reconstitus la configuration global pour l'application en appliquant la spécialisation de notre application. La séquence complète est documenté sur le [slide 14](http://adrienlauer.github.io/w20-ngparis/slides/#/14)

On a dans ce premier exemple un template intégré, qu'il est possible de sortir à la mode AngularJS.

Sur le [repository de code][adrien_sources], pour trouver l'exemple 'basic' qui utilise le module `culture` aka i18n, ainsi qu'il module imbriqué avec toutes sa définition. On voit ici la puissance du framework, tout le potentielle de réutilisabilité des modules. On peut noter qu'il n'y a pas de chemin relatif dans la configuration grâce à la [notation `{basic}`](https://github.com/adrienlauer/w20-ngparis/blob/master/samples/basic/basic/basic.w20.json#L9) qui permet la réutilisabilité du module.

### Conclusion

Je pense que ce framework est un vrai plus dans un environnement entreprise qui a la nécessité de créer plusieurs applications pour an. Le soucis de la réutilisabilité des fragments, l'utilisation de "l'injection" des dépendances, etc. Dans le futur, on pourra même peut-être l'utiliser au-delà de l'entreprise, avec bower pour autre pour récupérer les modules déjà écris et présents sur des repository de fragments.

La présentation était bien, efficace et démonstrative de la puissance potentiel de ce nouveau framework. Cependant, aucune source du core, aucune documentation et des exemples non utilisable.. C'est frustrant. Loin d'être la volonté d'Adrien ou des autres membres de PSA présent, il s'agit plus d'un soucis de rouage administratif relatif au grand groupe. J'espère qu'ils pourront montrer le travail qu'ils ont fait, et permettre à d'autres d'utiliser et d'améliorer W20.

### Sources

Vous pouvez trouver la [présentation sur Github][adrien_slides] ainsi que certains [code d'exemple][adrien_sources]. Par contre, les exemples permettent de voir la configuration mais ne pourront fonctionner car il n'y a pas le coeur du framework.

[adrien_slides]: http://adrienlauer.github.io/w20-ngparis/slides/#/
[adrien_sources]: https://github.com/adrienlauer/w20-ngparis/tree/master/samples

## Les `promises`

### Chakib Benziane

Chakib est freelance front. Vous pouvez le trouver sur Twitter ([@sp4ke][chakib_twitter]) et Github ([sp4ke][chakib_github])

[chakib_github]: https://github.com/sp4ke

### Les `promises`

Chakib revient sur différent paradigmes de programmation synchrone / asynchrone, pour comprendre l'intérêt des `promise`. Pour moi il est très important pour toutes les opérations longues: récupérations de longs listing, génération de statistiques, etc. Les `promises` sont d'ailleurs utilisés pour les `service`, `$http` et autres.

On peut donc continuer ne mettre notre appel bloquant dans une fonction, on rattachera cette fonction à une `promise` avec `$q.defer()`. Le tour est presque joué. 

Pour bien comprendre, Chakib nous propose le use-case suivant: une application mobile avec gestion de la bande passante / déconnexion. On peut faire ça avec un `timeout` mais on se trouve à mettre valeur fixe et donc un soucis lorsque le délai dépend du réseau. Deuxième solution, mettre une timeout exponentiel. Dans ce cas, on attends que rarement les 10 'retry' max.

Je pense qu'il y a plein d'autres choses à faire attention. Les `promises` ne sont pas les éléments que je maitrise vraiment et j'attendais donc beaucoup de cette présentation. Malheureusement, fatigue / fin de soirée / pizza / bières / problèmes techniques ont ralenti le talk et m'a capacité à tout apprécier.

### Conclusion

> Les promises mériteraient un meetup à part.

Je ne peux pas être plus en accord avec Chakib sur ce point. Il est possible de faire tellement de chose pour l'application et l'utilisateur en maitrisant cette fonctionnalité. Je regrette qu'à cause des soucis technique, la présentation n'est pas pu se dérouler parfaitement. Il faudrait donc peut-être revenir pour les `interceptors` et encore plus de cas pratiques sur les `promises`.

### Sources

Vous pouvez trouver la [présentation sur Github][chakib_slides] ainsi que le [code utilisé pour la démo][chakib_sources].

[chakib_slides]: http://sp4ke.com/angular-promises/slides/template.html#1
[chakib_sources]: https://github.com/sp4ke/angular-promises


## Conclusion

Merci aux speakers pour leurs travails, les démonstrations et leur procimité. Encore une belle soirée, un peu ternie par les soucis technique mais en tant que grand habitué des "effets démo" je leur tire mon chapeau!

À la prochaine!
