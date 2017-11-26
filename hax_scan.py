import nmap as nm

def nmap_scan(host, ports):
    print("Scanning ", host, ":", ports)
    ps = nm.PortScanner()
    ps.scan(host, ports)
    print("Hostnames: ", ps[host].hostnames())
    print("TCP: ", ps[host].all_tcp())
    print("UDP: ", ps[host].all_udp())
    return 0

def other_scan():
    return 0
