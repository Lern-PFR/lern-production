# Lern. - Structure de projets

## Problématique initiale

Lern. est composé de deux dépôts principaux : [lern-api](https://github.com/Lern-PFR/lern-api) et [lern-web](https://github.com/Lern-PFR/lern-web), qui contiennent respectivement le code source de l'API et du client web. Ces deux projets sont interdépendants mais ont été séparés afin de bénéficier d'historiques de code source, de cycles de tests automatisés et d'autres outils propres à chaque technologies, sans se retrouver submergés par une trop grande quantité d'informations *souvent hors sujet*.

L'objectif de ce choix est clair : faciliter la maintenance, le développement de fonctionnalités et la correction de bugs de chaque côté de notre architecture (*front-end* et *back-end*).

Malheureusement, cette séparation ajoute aussi une nouvelle problématique : ces deux projets devant cohabiter pour obtenir le produit final, il est nécessaire d'avoir un moyen de les rassembler tout en respectant l'objectif initial de faciliter la maintenance.

## Solution mise en place

Afin d'apporter une solution à cette problématique, un nouveau dépôt est né : [lern-production](https://github.com/Lern-PFR/lern-production).

Ce dépôt est en réalité un *meta-projet*, son rôle est de rassembler les dépôts principaux en un produit final utilisable quasiment instantanément.

### Références vers les dépôts principaux

[lern-production](https://github.com/Lern-PFR/lern-production) profite d'une fonctionnalité de git appelée **git submodules** afin de conserver une référence vers [lern-api](https://github.com/Lern-PFR/lern-api) et [lern-web](https://github.com/Lern-PFR/lern-web) *dans leur état à un instant T*.

Cette fonctionnalité nous permet de conserver à tout moment une version stable du projet, dont les mises à jour se font en deux étapes : tester le produit complet, puis changer les références pour pointer sur la version testée de chaque dépôt.

### Compilation et publication

Ce nouveau dépôt repose sur le principe qu'une nouvelle version stable est enregistrée par un nouveau commit mettant à jour les références vers les dépôts principaux.

Grâce à ses automatisations, l'intégration continue proposée par GitHub nous permet de compiler et de publier la version stable du produit sur [Docker Hub](https://hub.docker.com/r/lernpfr/lern) tout en ayant l'assurance que l'image créée corresponde en tout point à celle que nous avions testés à l'aide du même système de compilation.

## Conclusion

La structure de Lern. est basée sur trois dépôts : [lern-api](https://github.com/Lern-PFR/lern-api) et [lern-web](https://github.com/Lern-PFR/lern-web) (dépôts principaux), et [lern-production](https://github.com/Lern-PFR/lern-production) (dépôt de test local et de publication).

Cette organisation nous permet de maintenir la stabilité de la version publiée, et de profiter pleinement des outils de développement mis à disposition pour chaque technologie utilisée; sans avoir une montagne d'étapes de maintenance à chaque publication !
