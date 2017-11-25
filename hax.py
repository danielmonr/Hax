import sys
import nmap as nm
import hax_scan as scan

def main():
    h = '192.168.1.69'
    p = '20-9000'
    scan.nmap_scan(h,p)
    return 0

if __name__ == "__main__":
    main()
