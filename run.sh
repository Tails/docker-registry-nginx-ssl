#!/bin/bash

# generate pass based on env vars
htpasswd -b -c /etc/nginx/.htpasswd ${HTPASSWD_USER} ${HTPASSWD_PASS}

# determine hostname at runtime, maybe according
# to host specific bahaviour
/determine_hostname.sh

# prepare test cert command
if [ "${ENV}" = "debug" ]; then
  TEST="--test-cert"
fi

# run cert getter. the TEST env should be
# cleared for a working cert
/root/letsencrypt/letsencrypt-auto \
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
  mkdir -p /etc/nginx/ssl/ && \
  ln -s "/etc/letsencrypt/live/${DOMAIN}/fullchain.pem" "/etc/nginx/ssl/docker-registry.crt" && \
  ln -s "/etc/letsencrypt/live/${DOMAIN}/privkey.pem" "/etc/nginx/ssl/docker-registry.key" && \

  # start nginx
  nginx -g "daemon off;"

# allow SSH debugging
else
  sleep infinity
fi