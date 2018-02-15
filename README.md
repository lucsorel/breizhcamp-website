# Site Web BreizhCamp 2017

Ce site Web est généré avec [Hugo](https://gohugo.io/), _A Fast and Modern Static Website Engine_. La rapidité de génération est une des raisons du choix de cet excellent outil. Ce site est généré en quelques dizaines de millisecondes!

La majorité des contenus est écrit en Markdown ou sous forme de fichiers structurés YAML. Il est facile d'y contribuer directement depuis l'interface de GitHub.

Amis du BreizhCamp, n'hésitez pas à proposer des PR si vous voulez améliorer ce site!

## Développement

A la racine se trouve un wrapper pour lancer Hugo, qui se chargera de télécharger le binaire Hugo s'il n'est pas disponible. Pour lancer localement le site:

    ./hugow.sh -w serve

puis accéder à http://localhost:1313. Hugo activera le rechargement automatique des pages modifiées. Etant donné la vitesse de génération, les modifications effectuées dans les sources sont visibles en quasi-temps réel dans le navigateur Web.

### Mise à jours des données

#### Liste des speakers

1.  Dans le fichier `bin/getSpeakers.groovy`, remplacer `__TODO_TOKEN__` par votre token d'authentification.
    **NE FAITES PAS UN COMMIT DE CE FICHIER AVEC VOTRE TOCKEN DEDANS !**
1.  Lancer le script `bin/update-json-speakers.sh`
1.  Faire un commit du fichier `data/speakers.json`


## Organisation des branches

Ce dépot possède 2 branches, `staging` et `production`. La branche `production` doit être alimenté par des merges depuis la branche `staging`.

## Déploiement

L'instance [Jenkins du BreizhCamp]( https://breizhcamp.ci.cloudbees.com) permet de déployer automatiquement les branches principales de ce dépôt:

* la branche `staging` est déployée sur http://www-staging.breizhcamp.org
* la branche `production` est déployée sur http://www.breizhcamp.org

Les pages HTML générées sont servies par GitHub Pages et sont stockées dans:

* [breizhcamp/www-staging](https://github.com/breizhcamp/www-staging) pour la branche `staging`
* [breizhcamp/www-2017](https://github.com/breizhcamp/www-2017) pour la branche `production`

Les scripts de déploiement utilisé par l'intégration continue Jenkins sont dans le répertoire `bin`.

# Dévelopment Web et Hugo

Quelques liens pour les non professionels du CSS et de Hugo

* http://cssreference.io/
