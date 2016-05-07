FROM marvambass/nginx-registry-proxy
ENV EMAIL test@example.com
ENV DOMAIN example.com
ENV TEST --test-cert
RUN apt-get update && apt-get install -y git && apt-get clean yoself
RUN (cd ~/ && \
     git clone https://github.com/letsencrypt/letsencrypt && \
     ~/letsencrypt/letsencrypt-auto --help)
ADD run.sh /run.sh
RUN chmod +x /run.sh
#CMD /run.sh
CMD sleep infinity