#!/bin/bash

set -e

MINA="mina"
FILE=/home/{{ user }}/deploy.rb
UP=/home/{{ user }}/up
SHA=$1

if [ -z ${SHA} ] ; then
  echo "Usage: $0 SHA"
  exit 1
fi

force_assets=1 force_migrate=1 ${MINA} -S -f ${FILE} deploy | grep -v 'Elapsed' > $UP
chmod +x up
rm -f deploy.lock
bash $UP

touch {{deploy_to}}/current/${SHA}

