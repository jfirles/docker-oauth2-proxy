FROM debian:bullseye-slim
MAINTAINER Jose Fco. Irles <jfirles@siptize.com>
LABEL maintainer="jfirles@siptize.com"
LABEL "com.siptize.vendor"="Siptize S.L."
LABEL "com.siptize.project"="common"
LABEL "com.siptize.app"="oauth2-proxy"
LABEL "com.siptize.version"="1.0.0_oauth2-proxy-7.4.0"
LABEL version="1.0.0_oauth2-proxy-7.4.0"

## zona horaria
RUN echo "Europe/Madrid" > /etc/timezone
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime

## actualizamos e instalamos lo basico
RUN apt-get update && apt-get dist-upgrade -y && apt-get install locales ca-certificates -y && apt-get clean

## Locales
RUN echo "LANG=es_ES.UTF-8" > /etc/default/locale && echo "LC_MESSAGES=POSIX" >> /etc/default/locale \
 && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen \
 && /usr/sbin/locale-gen

## VARIABLES
ENV OAUTH2_PROXY_VERSION 7.4.0
ENV OAUTH2_PROXY_BASE_URL https://github.com/oauth2-proxy/oauth2-proxy/releases/download
ENV OAUTH2_PROXY_ARCH amd64
ENV OAUTH2_PROXY_TGZ oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-$OAUTH2_PROXY_ARCH.tar.gz
ENV OAUTH2_PROXY_DOWNLOAD_URL $OAUTH2_PROXY_BASE_URL/v$OAUTH2_PROXY_VERSION/$OAUTH2_PROXY_TGZ

## Descargamos el tar.gz de oauth2
ADD $OAUTH2_PROXY_DOWNLOAD_URL /tmp/

## descomprimimos
RUN tar xfz /tmp/$OAUTH2_PROXY_TGZ -C /tmp && cp /tmp/oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-$OAUTH2_PROXY_ARCH/oauth2-proxy /usr/local/bin && rm -rf /tmp/oauth2-proxy-v$OAUTH2_PROXY_VERSION.linux-$OAUTH2_PROXY_ARCH && rm /tmp/$OAUTH2_PROXY_TGZ && chmod a+x /usr/local/bin/*

EXPOSE 4180

USER 65534:65534

CMD ["/usr/local/bin/oauth2-proxy"]
