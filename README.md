# Docker Registry 2.0 Proxy

Use this image to run Docker Registry 2.0 behind nginx proxy, with SSL and basic_auth enabled.

## Settings

First run official Docker Registry 2.0 container:

```
#!/bin/bash
docker run --name registry registry:2.0
```

Then run the proxy:

```
#!/bin/bash
docker run -p 443:443 \
	-e DOMAIN="my.nginx.host" \
	-e ENV="production" \
	--link docker-registry:registry \
	tabbas/docker-registry-nginx-ssl
```

## Environment Variables

- REGISTRY_HOST ... hostname of the registry container
- REGISTRY_PORT ... port number of the registry container
- SERVER_NAME ... nginx server_name directive value
- DOMAIN ... external hostname of the nginx container (needed for auto SSL generation)
- EMAIL ... email address to register SSL certificate with
- HTPASSWD_USER ... username for registry basic auth
- HTPASSWD_PASS ... password for registry basic auth
- ENV ... set this to 'production' to enable real certificate

## Automation

edit /determine_hostname.sh script for resolving the container hostname at runtime
