#!/bin/bash

export DOMAIN_NAME="nas.voronenko.net"

mkdir -p ./traefik_certs

source ~/.acme.sh/acme.sh.env

~/.acme.sh/acme.sh --install-cert -d "${DOMAIN_NAME}" \
        --cert-file ./traefik_certs/cert.pem \
        --key-file  ./traefik_certs/privkey.pem \
        --fullchain-file ./traefik_certs/fullchain.pem

chmod g-rw ./traefik_certs/*
chmod o-rw ./traefik_certs/*

