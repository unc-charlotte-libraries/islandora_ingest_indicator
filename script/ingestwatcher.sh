#!/bin/bash
drush_ready=$(ps aux 2>/dev/null |grep drush 2>/dev/null |wc -l)
loadingdock_ready=$(/usr/bin/lsof /mnt/islandora-loadingdock | grep -e "[[:digit:]]\+[wu]\{1\}" |wc -l)
drupalfiles_ready=$(/usr/bin/lsof /var/www/html/sites/default/files | grep -e "[[:digit:]]\+[wu]\{1\}" |wc -l)
if (( $drush_ready == '0' || $drush_ready == '1' && $loadingdock_ready == '0' && $drupalfiles_ready == '0'))
then
echo "#00FF00" > /var/www/html/blink/ingeststatus.txt
else 
echo "#FF0000" > /var/www/html/blink/ingeststatus.txt
fi
