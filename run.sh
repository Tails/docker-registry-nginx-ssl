#!/bin/bash
~/letsencrypt/letsencrypt-auto \
  certonly \
  ${TEST} \
  --agree-tos \
  --standalone \
  --non-interactive \
  --redirect \
  --text \
  -d ${DOMAIN}
ls -l ~/