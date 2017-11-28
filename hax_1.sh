#!/bin/bash
if [ $# -ne 1 ]; then
echo "Wrong number of arguments"
exit 1
else
rm -f comnds.txt msf.txt
echo "workspaces add hax" >> comnds.txt
echo "add domains $1" >> comnds.txt
echo "use recon/domains-hosts/bing_domain_web" >>comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-hosts/google_site_web" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-hosts/brute_hosts" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-hosts/netcraft" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/hosts-hosts/resolve" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/hosts-hosts/reverse_resolve" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/hosts-hosts/ipinfodb" >> comnds.txt
echo "run" >> comnds.txt
echo "use recon/domains-vulnerabilities/xssposed" >> comnds.txt
echo "run" >> comnds.txt
echo "use reporting/list" >> comnds.txt
echo "set FILENAME $PWD/hosts.txt" >> comnds.txt
echo "run" >> comnds.txt
echo "use reporting/csv" >> comnds.txt
echo "set FILENAME $PWD/hosts.csv" >> comnds.txt
echo "run" >> comnds.txt
echo "back" >> comnds.txt
echo "workspaces delete hax"
echo "exit" >> comnds.txt

recon-ng -r $PWD/comnds.txt

nmap -iL $PWD/hosts.txt -Pn -F -oG $PWD/nmap.txt

while read p; do
  rm -f $PWD/msf.txt
  echo "use auxiliary/scanner/ftp/ftp_login" >> msf.txt
  echo "set RHOSTS $p" >> msf.txt
  echo "set THREADS 205" >> msf.txt
  echo "set USERNAME msfadmin" >> msf.txt
  echo "set VERBOSE false" >> msf.txt
  echo "run" >> msf.txt
  echo "exit" >> msf.txt
  msfconsole -r $PWD/msf.txt
  wpscan --url $p --enumerate
done < $PWD/hosts.txt
fi
