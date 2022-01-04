#!/bin/bash
curl -F "file=@$1" "http://$2/"
