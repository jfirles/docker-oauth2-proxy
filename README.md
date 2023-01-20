# docker-oauth2-proxy
Docker container for oauth2-proxy

# Usage
Add environtment variables to configure

## Example for keycloak with ENV variables
```
docker run --name oauth2-proxy -e OAUTH2_PROXY_PROVIDER=keycloak-oidc \
	-e OAUTH2_PROXY_CLIENT_ID=myclientid \
	-e OAUTH2_PROXY_CLIENT_SECRET=myclientsecret \
	-e OAUTH2_PROXY_COOKIE_SECRET=12345678901234567890123456789012 \
	-e OAUTH2_PROXY_EMAIL_DOMAINS="*" \
	-e OAUTH2_PROXY_OIDC_ISSUER_URL=https://mykeycloakinstance.com/realms/myrealm \
	-e OAUTH2_PROXY_REDIRECT_URL=https://mysecuredservice.com/oauth2/callback \
	josefu/oauth2-proxy:latest
```

## Example for keycloak with custom config file
```
docker run --name oauth2-proxy -v /data/oauth2-proxy/oauth2-proxy.cfg:/opt/oauth2-proxy.cfg \
	josefu/oauth2-proxy:latest --config=/opt/oauth2-proxy.cfg
```
