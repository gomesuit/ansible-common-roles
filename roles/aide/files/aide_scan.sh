#!/bin/sh

aide -u | logger -i -t aide_scan -p local6.notice
mv -f /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz

