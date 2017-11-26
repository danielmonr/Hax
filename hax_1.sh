#!/bin/bash
if [ $# -ne 1 ]; then
echo "Wrong number of arguments"
exit 1
else
rm -f comnds.txt
echo "workspaces add $1" >> comnds.txt
echo "add domains $1.com" >> comnds.txt
echo "use recon/domains-hosts/bing_domain_web" >>comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-host/google_site_web" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-hosts/brute_hosts" >> >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-hosts/netcraft" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/hosts-hosts/resolve" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/hosts-hosts/reverse_resolve" >> comnds.txt
echo "" >> comnds.txt


recon-ng -r $PWD/comnds.txt
fi
