#!/usr/bin/python
# @author Vsevolod Ivanov
# @description ./csv2rumble.py scan.rumble.csv scan.rumble.gz

import sys
import pandas as pd
import gzip
import json

def convert_csv_to_json_gz(csv_file_path, json_gz_file_path):
    df = pd.read_csv(csv_file_path, header=None)

    json_str = df.to_json(orient='records', lines=True)

    with gzip.open(json_gz_file_path, 'wt', encoding='UTF-8') as gz_file:
        gz_file.write(json_str)

if __name__ == "__main__":
    csv_file_path = sys.argv[1]
    json_gz_file_path = sys.argv[2]
    convert_csv_to_json_gz(csv_file_path, json_gz_file_path)
