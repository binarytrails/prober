#!/usr/bin/python
# @author Vsevolod Ivanov

import sys
import pandas as pd

jsonObj = pd.read_json(path_or_buf=str(sys.argv[1]), lines=True)
jsonObj.to_csv('scan.rumble.csv', encoding='utf-8', index=False)
