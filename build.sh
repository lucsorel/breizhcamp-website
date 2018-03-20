#!/bin/bash

echo "Building branch $BRANCH_NAME"

if [[ $BRANCH_NAME = production ]]; then
  bin/build.sh -p
else
  bin/build.sh
fi

bin/publish.sh
