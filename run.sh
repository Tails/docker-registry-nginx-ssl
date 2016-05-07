#!/bin/bash
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
ls -l ~/