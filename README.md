# Lern.

[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://hub.docker.com/r/lernpfr/lern)

Lern. est une plateforme communautaire de cours en ligne.

Ce dépôt représente la dernière version stable du projet, ainsi que la dernière version disponible sur [Docker Hub](https://hub.docker.com/r/lernpfr/lern).

## Installation

### Avec l'image Docker officielle (recommandé)

```bash
docker run -p 80:80 -p 443:443 lernpfr/lern
```

La page d'accueil est accessible par [http://127.0.0.1/](http://127.0.0.1/) ou [http://localhost/](http://localhost/).

Les ports `80:80` et `443:443` peuvent être changés au besoin (par exemple : `8080:80` ou `4343:443`).

### Création manuelle d'une image

```bash
# Récupération du code source
git clone --recursive https://github.com/Lern-PFR/lern-production.git && cd lern-production
# Compilation et création de l'image Docker
docker build . -t lernpfr/lern-custom
# Lancement de Lern.
docker run -p 80:80 -p 443:443 lernpfr/lern-custom
```

## Structure du projet

Des informations complémentaires sur la structure du projet sont disponibles dans le fichier [ABOUT.md](ABOUT.md).
