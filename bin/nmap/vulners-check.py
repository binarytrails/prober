#!/usr/bin/python3
import argparse
from pathlib import Path
import json

import nmap
import vulners as v

api_key = "API_KEY"
v = v.VulnersApi(api_key)

def read_nmap(file):
    nm = nmap.PortScanner()
    nm.analyse_nmap_xml_scan(open(file).read())

    software = []

    for host in nm.all_hosts():
        for proto in nm[host].all_protocols():
            for port in nm[host][proto].keys():
                service = nm[host][proto][port]
                name = service.get("name")
                product = service.get("product")
                version = service.get("version")

                if product:
                    software.append((product, version))

    return software

def query_vulners(software):
    """
    software = [
        {
            "product": "Apache",
            "version": "12.",
        }
    ]
    """
    return v.audit_software(software, match="partial")

BANNER = r"""
              (                            (       )               )   
 (   (    (   )\          (   (            )\   ( /(    (       ( /(   
 )\  )\  ))\ ((_) (      ))\  )(   (     (((_)  )\())  ))\  (   )\())  
((_)((_)/((_) _   )\ )  /((_)(()\  )\    )\___ ((_)\  /((_) )\ ((_)\   
\ \ / /(_))( | | _(_/( (_))   ((_)((_)  ((/ __|| |(_)(_))  ((_)| |(_)  
 \ V / | || || || ' \))/ -_) | '_|(_-<   | (__ | ' \ / -_)/ _| | / /   
  \_/   \_,_||_||_||_| \___| |_|  /__/    \___||_||_|\___|\__| |_\_\   
                                                                    
"""

INFO = """
This tool parses software names + versions, iqueries Vulners for CVEs,
and writes results as JSON files inside vulners_cves_<filename>.

Install dependencies:

    pip3 install vulners python-nmap

Find files with open ports:
    
    cat *.nmap | grep "open  " *.nmap

Chain files with script:
    
    for file in $(cat *.nmap | grep -l "open  " *.nmap); do
        python vulners-check.py $file;
    done

by <Vsevolod Ivanov, github.com/binarytrails> =).
"""

print(BANNER)
print(INFO)

parser = argparse.ArgumentParser()
parser.add_argument("file", help="input file with product,version lines")
args = parser.parse_args()
filename_nmap = args.file
filename = str(Path(filename_nmap).with_suffix(".xml"))

software_list = read_nmap(filename)
print(software_list)

folder_name = f"vulners_cves_{Path(filename).stem}"
Path(folder_name).mkdir(exist_ok=True)

for product_version in software_list:

    # will be filled with unrelated false positives
    if (not product_version[1]):
        print("Did not find " + product_version[0] + " version. Skipping.")
        pass
    
    software = [
        {
            "product": product_version[0],
            "version": product_version[1]
        }
    ]
    
    cves = query_vulners(software)
    if cves:
        print(cves)

        # Write JSON file: <product>_<version>.json
        out_file = Path(folder_name) / f"{product_version[0]}_{product_version[1]}.json"

        with open(out_file, "w") as f:
            json.dump(cves, f, indent=4)

        print(f"[+] Saved {out_file}")

