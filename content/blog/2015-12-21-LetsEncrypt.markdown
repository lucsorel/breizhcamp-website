+++
title = "Un peu de sécurité"
date = "2015-12-21T16:39:38+02:00"
banner = "img/blog/2016-12-21/acme.jpg"
author = "Sylvain"
+++

Depuis le 3 décembre, [Let's Encrypt](https://letsencrypt.org/) est passée dans sa phase d'Open Beta.
Nous avons donc décidé d'en profiter pour exposer le [CFP](https://cfp.breizhcamp.org) en HTTPS.

## Préambule

Avant d'expliquer les étapes techniques de mise en œuvre, arrêtons nous un instant sur Let's Encrypt : il s'agit d'une autorité de certification libre qui apporte la possibilité d'obtenir des certificats X.509 pour le chiffrement TLS.
La nouveauté réside principalement dans la combinaison de 3 éléments :

 *    Le service est gratuit. Il suffit de "posséder" un nom de domaine pour pouvoir l'utiliser.

 *    Le service est automatisable, notamment grâce à l'utilisation du protocole [ACME](https://en.wikipedia.org/wiki/Automated_Certificate_Management_Environment) : Automated Certificate Management Environment.

![ACME](/img/blog/2016-12-21/acme.jpg)

 *    Le service est opéré par un groupement d'intérêt public, [l'ISRP](https://letsencrypt.org/isrg/) : Internet Security Research Group, ayant pour but une gouverance ouverte et transparente.

Il devient donc possible d'obtenir automatiquement et gratuitement des certificats émis par une autorité de certification en laquelle on peut *a priori* avoir confiance, ce qui représente une belle avancée pour la sécurité sur Internet.

## Mise en œuvre

Passons maintenant au déploiement du certificat sur le CFP du Breizhcamp. Ce déploiement va se dérouler en deux étapes : la génération du certificat (et des éléments nécessaires à son utilisation), et la mise en place de ce certificat dans l'application.
Je ne vais pour le moment vous parler que de la première partie, la génération du certificat.

Let's Encrypt fournit un [client en python](https://github.com/letsencrypt/letsencrypt) permettant l'interaction avec son autorité de certification. Bien que ce client ne soit pas parfait (n'oublions pas qu'il s'agit encore d'une Beta), nous allons quand même nous baser sur lui pour l'obtention du certificat.
Ce client nécessite notamment que le port 80 soit "disponible" pour les échanges dans le cadre du protocole ACME, et il a besoin d'être exécuté sur la machine portant le nom de domaine pour lequel on souhaite un certificat.
J'ai donc choisi d'exécuter le client dans un conteneur Docker sur le serveur de production du CFP (qui n'était pas encore ouvert à l'époque, je me suis donc autorisé l'interruption de service générée par le fait d'arrêter le CFP le temps de générer le certificat).

Après avoir arrêté le conteneur du CFP, j'ai donc lancé un nouveau conteneur Ubuntu en prenant le soin d'exposer le port 80 :

```
docker run -ti -p 80:80 ubuntu /bin/bash
```

Puis j'ai installé et exécuté le client Let's encrypt dans mon conteneur. Le client est exécuté en mode "standalone" et "certonly" (il lance un serveur HTTP sur le port 80, et génère les certificats sans chercher à les déployer) :

```
apt-get update
```

```
apt-get install -y git
```

```
git clone https://github.com/letsencrypt/letsencrypt
```

```
cd letsencrypt
```

```
./letsencrypt-auto --help all
```

```
./letsencrypt-auto certonly --standalone --email contact@breizhcamp.org -d cfp.breizhcamp.org
```

Et voilà, le dossier `/etc/letsencrypt/` contient maintenant votre certificat, la clé privée associée, et la chaîne de certification complète. Il ne reste plus qu'à l'utiliser dans votre serveur Web préféré (ou, comme nous l'expliquerons dans un autre article, dans votre application Spring Boot).
