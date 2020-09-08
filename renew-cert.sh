#!/bin/bash

BASEDIR=$(dirname "$0")
MAIN_APP_ENV_FILE=$BASEDIR/.env

if [ -f "$MAIN_APP_ENV_FILE" ]; then
    echo "Sourcing $MAIN_APP_ENV_FILE"
    dos2unix $MAIN_APP_ENV_FILE
else 
    echo "File $MAIN_APP_ENV_FILE does not exist."
    exit 1
fi

set -a # automatically export all variables
source $MAIN_APP_ENV_FILE
set +a

$GREENLOCK_BIN certonly --webroot \
  --acme-version draft-11 --acme-url https://acme-staging-v02.api.letsencrypt.org/directory \
  --agree-tos --email $GREENLOCK_EMAIL --domains $GREENLOCK_DOMAINS \
  --community-member \
  --root "$GREENLOCK_WEBROOT" \
  --privkey-path "$MAIN_APP_BASE_FOLDER/ssl/:hostname/key.pem" \
  --fullchain-path "$MAIN_APP_BASE_FOLDER/ssl/:hostname/ssl.crt" \
  --config-dir "$GREENLOCK_CONFIG_DIR"