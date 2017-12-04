---
author:
  email: adrien.lecharpentier@gmail.com
  name: Adrien Lecharpentier
date: 2013-05-30T15:15:12Z
tags: dev java
title: Never ever use finalize in Java
url: /2013/05/30/never-ever-use-finalize-in-java/
---

À moins de s'avoir parfaitement ce que vous faite et comment ce que vous faites sera utilisé dans le futur...

Parce que lorsque l'on fait du support, en général on ne touche pas trop à du code bien fait / écrit ni fonctionnel (un produit qui fonctionne n'a pas besoin de support), je vois par moment des choses qui peuvent piquer les yeux.

Dernier en date : utilisation de la méthode `finalize` de Java.

## Rappel

En C++, il y a les destructeurs, donc on pourrait penser que c'est la même chose : pas du tout ! Le destructeur en C++ est responsable de la désallocation de la mémoire utilisée par l'objet.

La méthode `finalize` est appelée lorsque le GC passe sur l'instance d'une classe. On peut alors souhaiter effectuer certaines actions à ce moment là mais il faut faire très attention car une simple raison : on ne sait pas quand le GC passe !

## Mise en situation de ce qu'il ne faut pas faire

### Code

{{< highlight java >}}
public class A {
	private B b;
		
	@Override
	public void finalize() {
		b.setC(null);
	}
}
{{< / highlight >}}

{{< highlight java >}}
public class B {
	private C c;
	
	public void setC(C c) { this.c = c; }
	
	public String toString() { return "B: " + c.toString(); }
}
{{< / highlight >}}

{{< highlight java >}}
public class C {
	public String toString() { return "C" }
}
{{< / highlight >}}

### Exécution

Si votre classe B est un singleton géré par un système tiers, alors on pourrait avoir 10000 instances de A avec la même instance de B. Si, par manque de ressources ou parce que le GC veut faire un peu de ménage, le GC supprime au moins une instance de A, alors 

> "You gonna have a bad time"

### Explication

Lors du passage du GC, les méthodes `finalize` sont appelées, sur le principe que toute classe est une fille de la classe `Object` qui définit cette méthode. Donc si une instance de A est déchargée, elle va mettre à `null` la référence à une instance de C dans l'instance de B.

> NPE guaranteed 

En effet, l'instance de la classe B est toujours utilisé par d'autres instance de la classe A. 

## Conclusion

Il y a quelques années, un enseignant nous avait dit :

> "Le premier que je vois redéfinir `finalize` sans une excellente raison passera un sale quart d'heure", __Rémi FORAX__.

Depuis j'applique ce précepte : "Je ne sais pas suffisamment comment ça sera utilisé pour être capable de faire une redéfinition parfaite", donc je ne redéfinis __jamais__ la méthode `finalize`.


