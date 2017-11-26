if [ $# -ne 1 ]; then
echo "Wrong number of arguments"
exit 1
else
nmap -p21 -Pn $1 -oG out.gnmap
cat out.gnmap | grep open | cut -d " " -f 2 > ftp_hosts.txt
echo "Hosts with port 21 open: "
cat ftp_hosts.txt
echo "Hosts with port 21 closed:"
cat out.gnmap | grep closed | cut -d " " -f 2
fi
