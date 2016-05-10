FROM containersol/docker-registry-proxy

# modify these
ENV EMAIL test@example.com
ENV DOMAIN example.com

# assume defaults
ENV REGISTRY_HOST registry
ENV REGISTRY_PORT 5000
ENV SERVER_NAME localhost

# set this to "production" in impl to generate working cert
ENV ENV debug

# install letsencrypt tool
RUN apt-get update && apt-get install -y git && apt-get clean yoself
RUN (cd ~/ && \
     git clone https://github.com/letsencrypt/letsencrypt && \
     ~/letsencrypt/letsencrypt-auto --help)

# letsencrypt runner
ADD run.sh /run.sh
RUN chmod +x /run.sh

# entrypoint
CMD /run.sh