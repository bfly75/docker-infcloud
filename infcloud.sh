#!/usr/bin/env ash
[ ! -f /srv/infcloud/config/config.js ] && cp /srv/infcloud/config.js.orig /srv/infcloud/config/config.js
/srv/infcloud/cache_update.sh
lighttpd -D -f /etc/lighttpd/lighttpd.conf
