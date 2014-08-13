---
layout: post
date: 2014-08-13
author:
  name: Adrien Lecharpentier
  email: adrien.lecharpentier@gmail.com
title: Les tests d'intégrations de jenkins-client
tags: opensource github jenkins test integration
---

Pour une idée de projet de supervision de Jenkins, j'ai cherché s'il existait une librairie permettant de communiquer simplement avec une instance de Jenkins (via son API Rest). J'ai trouvé [`jenkins-client`][jenkins-client] sur le Github de RisingOak.

[jenkins-client]: https://github.com/RisingOak/jenkins-client

J'ai pris l'habitude, lorsque je trouve une librairie comme celle-ci, de regarder le code et le packager. Ceci me permet de voir si je peux ajouter du comportement à la librarie simplement. Pour `jenkins-client`, rien de bien compliqué : 

{% highlight powershell %}
git clone git@github.com:RisingOak/jenkins-client.git
mvn clean verify
{% endhighlight %}

Pourquoi un `mvn verify` plutôt qu'un simple `mvn package`? Car le build _maven_ pourrait être configuré pour exécuter des tâches particulières sur le _.jar_ généré qui serait important.

La surprise a été d'avoir des tests en échec sur une repository vierge. Pour moi, c'est impossible d'avoir sur la branche principale du projet du code qui n'est pas valide. Je pense que j'en reparlerai à propos de __git-flow__.

>Tip : sur _Github_, il vous est possible de définir quelle est la branche principale du projet et donc celle automatiquement checkoutée lors du clone.

## Environnement

Je suis donc allé voir de plus près le _Readme_ du projet pour comprendre si j'ai raté une étape, un profile ou quelque chose d'autre. Il se trouve que des tests d'intégrations sont écrits sur ce projet: parfait ! C'est une excellente nouvelle puisqu'ainsi je serai sûr de ne rien casser lors de mes développements. Cependant, le projet n'est pas validé en l'état. 

Les tests d'intégrations étant plus complexes, il est souvent nécessaire de mettre en place un environnement pour les exécuter. Ici, il est nécessaire :

 - d'avoir un Jenkins local sur le port 8080 ;
 - d'avoir quelques jobs créés, avec des noms précis ;
 - d'avoir un plugin installé ;
 - etc.

Ce n'est pas bon : en aucun cas, ces tests ne sont portables, ni exécutables dans un processus d'intégration continue. Je ne pourrais vous dire combien de fois j'ai vu des Jenkins utiliser le port 8080. Il faudrait donc que le Jenkins qui sert à builder cette librairie ait également des faux jobs pour valider la librairie. Impossible. 

De plus, cette classe de test est exécutée en même temps que les tests unitaires. Mauvaise idée.

## Ma Pull-Request

J'ai donc pris l'initiative de changer cela et de voir si ça pourrait intéresser les développeurs principaux de la librairie.

### _maven-failsafe-plugin_

La première étape a été de transformer le test d'intégration déguisé en test unitaire, en test d'intégration à part entière. Très simple, on configure _maven_ pour utiliser le plugin [_maven-failsafe-plugin_][failsafe] et on renomme la classe de tests `JenkinsServerTest` vers `JenkinsServerIT` : [détail du commit][commit-1].

[failsafe]: http://maven.apache.org/surefire/maven-failsafe-plugin/
[commit-1]: https://github.com/RisingOak/jenkins-client/commit/841711a02c76934276db789e8db3c661f13cfdd2

### Ré-écriture des tests d'intégration

Il faut ensuite retirer l'utilisation du Jenkins local dans tous les tests d'intégration. C'est un peu plus long. Par chance, les core développeurs de Jenkins ont, depuis la version _1.477.2_, mis en place un module permettant d'avoir un Jenkins virtuel (`JenkinsRule`) avec la librairie `jenkins-test-harness`.

Pour cela, j'ai utilisé la classe `JenkinsRule` avec l'annotation `@org.junit.Rule` pour avoir une instance de Jenkins démarrée lors de chacun de mes tests. La structure interne de mes tests est ensuite toujours semblable en suivant le pattern suivant :

{% highlight java %}
//given
jenkinsRule.getInstance().createProject(hudson.model.FreeStyleProject.class, "job-name");

//when
java.util.Map<String, com.offbytwo.jenkins.model.Job> jobNames = jenkinsServer.getJobs();

//then
assertTrue(jobNames.containsKey("job-name"));
{% endhighlight %}

Avec le `jenkinsRule`, je crée les jobs et environnements nécessaires pour ce que je veux tester. J'utilise ensuite les classes de la librairie pour récupérer ou injecter des informations depuis / sur le `jenkinsRule`. Pour finir, je valide les informations récupérées. [Plus de détails ici][commit-2].

[commit-2]: https://github.com/RisingOak/jenkins-client/commit/981207797133f14ed1280fdb224739dcc8221256

## Conclusion

En transformant les tests d'intégration de la sorte, je me suis assuré que tout le monde pourrait les faire fonctionner rapidement et surtout les reproduire. En introduisant une propriété dans le build _maven_ pour la version du Jenkins à utiliser, je peux en plus changer dynamiquement la version de Jenkins et donc confronter la librairie à une multitude de Jenkins en batch :

{% highlight powershell %}
mvn clean verify -Djenkins-version=1.554.3
{% endhighlight %}

On peut ainsi dire rapidement si une fonctionnalité de la librairie est compatible avec les dernières versions de Jenkins ou à partir de quelle version une fonctionnalité est opérationnelle.

Ma pull-request a été acceptée et vous pouvez donc retrouver mon développement dans le code de la librairie. 
