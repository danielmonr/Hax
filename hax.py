import sys
import nmap as nm
import hax_scan as scan

def main():
    h = '192.168.1.69'
    p = '20-9000'
    h2 = '148.241.97.139'
    scan.nmap_scan(h,p)
    scan.nmap_scan(h2, p)
    return 0

if __name__ == "__main__":
    main()
