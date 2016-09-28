#!/bin/bash
# applique le patch pour les couleurs de theme au style par défaut
# pour générer le style orange
#
# Vous allez me dire, il est fou ce garçon... le fichier diff initial
# correspond au diff entre 2 thèmes existants, comme ça, on est sur
# de ne modifier que les couleurs nécessaires :P

HERE="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

patch -i "$HERE/style.orange.patch" -o "$HERE/static/css/style.orange.css" "$HERE/themes/hugo-universal-theme/static/css/style.default.css"
