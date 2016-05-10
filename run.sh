#!/bin/bash

# prepare test cert command
if [ "${ENV}" = "debug" ]; then
  TEST="--test-cert"
fi

# run cert getter. the TEST env should be
# cleared for a working cert
~/letsencrypt/letsencrypt-auto \
  certonly \
  ${TEST} \
  --agree-tos \
  --standalone \
  --non-interactive \
  --redirect \
  --text \
  --email ${EMAIL} \
  -d ${DOMAIN}

# show generated certs
ls -l "/etc/letsencrypt/live/${DOMAIN}"

# in production, install certs in nginx
if [ "${ENV}" = "production" ]; then
  
  # TODO: check if generation worked

  # install certs in nginx
  ln -s "/etc/letsencrypt/live/${DOMAIN}/cert.pem" "/etc/nginx/ssl/docker-registry.crt"
  ln -s "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" "/etc/nginx/ssl/docker-registry.key"

  # start nginx
  nginx

# allow SSH debugging
else
  sleep infinity
fi