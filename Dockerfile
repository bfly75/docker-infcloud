FROM alpine:3.18

ENV VERSION  0.13.1

RUN apk --no-cache update && apk --no-cache upgrade \
    && apk --no-cache add unzip wget ca-certificates lighttpd \
    && mv /etc/lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf.apk-new \
    && wget --progress=dot:giga https://www.inf-it.com/InfCloud_$VERSION.zip \
    && unzip InfCloud_*.zip -d /srv/ \
    && rm InfCloud_*.zip \
    && mkdir -p /srv/infcloud/config \
    && cp /srv/infcloud/config.js /srv/infcloud/config/config.js \
    && mv /srv/infcloud/config.js /srv/infcloud/config.js.orig \
    && mv /srv/infcloud/cache_update.sh /srv/infcloud/cache_update.sh.orig \
    && ln -s /srv/infcloud/config/config.js /srv/infcloud/config.js \
    && sync; /srv/infcloud/cache_update.sh \
    && apk del -rf --purge unzip wget ca-certificates

COPY --chmod=0755 cache_update.sh /srv/infcloud/cache_update.sh
COPY --chmod=0755 infcloud.sh /usr/local/bin/infcloud
COPY --chmod=0644 lighttpd.conf /etc/lighttpd/lighttpd.conf

EXPOSE 80

ENTRYPOINT ["infcloud"]
