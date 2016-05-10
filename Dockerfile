FROM containersol/docker-registry-proxy

# modify these
ENV EMAIL test@example.com
ENV DOMAIN example.com
ENV HTPASSWD_USER user
ENV HTPASSWD_PASS admin

# assume defaults
ENV REGISTRY_HOST registry
ENV REGISTRY_PORT 5000
ENV SERVER_NAME localhost

# set this to "production" in impl to generate working cert
ENV ENV debug

# install letsencrypt tool
RUN apt-get update && \
    apt-get install -y git apache2-utils && \
    apt-get clean yoself

RUN (cd ~/ && \
     git clone https://github.com/letsencrypt/letsencrypt && \
     ~/letsencrypt/letsencrypt-auto --help)

# letsencrypt runner
ADD run.sh /run.sh
RUN chmod +x /run.sh

# generate htpassword for basic auth
RUN htpasswd -b -c /etc/nginx/.htpasswd ${HTPASSWD_USER} ${HTPASSWD_PASS}

# entrypoint
CMD ["/run.sh"]