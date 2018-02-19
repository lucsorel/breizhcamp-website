#!/usr/bin/env bash
set -eu -o pipefail

# MacOS lover's, I did not forget you ;)
PROJECT_ROOT="$(cd -P "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"
cd "$PROJECT_ROOT"


function die {
    echo "$1"
    exit 1
}


GROOVY_FILENAME="getSpeakers.groovy"
JQ_FILENAME="extract-speakers-json.jq"
OUTPUT_FILEPATH="${PROJECT_ROOT}/data/speakers.json"

GROOVY_FILEPATH="${PROJECT_ROOT}/bin/${GROOVY_FILENAME}"
JQ_FILEPATH="${PROJECT_ROOT}/bin/${JQ_FILENAME}"


# Check if auth token has been set
grep -q "__TODO_TOKEN__" "${GROOVY_FILEPATH}" \
    && die "Pensez à remplacer le token d'authentification '__TODO_TOKEN__' par votre token dans le fichier ${GROOVY_FILEPATH} !"

# Get data...
groovy "${GROOVY_FILEPATH}"  | jq -f "${JQ_FILEPATH}" > "${OUTPUT_FILEPATH}"

echo "Le fichier a bien été mis à jour : ${OUTPUT_FILEPATH}"
