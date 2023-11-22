#!/usr/bin/python
# @author Vsevolod Ivanov
# @description rumble2csv.py scan.rumble.gz scan.rumble.csv

import sys
import pandas as pd

jsonObj = pd.read_json(path_or_buf=str(sys.argv[1]), lines=True)
jsonObj.to_csv(str(sys.argv[2]), encoding='utf-8', index=False)
