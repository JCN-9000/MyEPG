#!/bin/bash

cd $HOME/WG

# Update EPG

mono WebGrab+Plus.exe $HOME/WG

# Convert

python xml2json.py -t xml2json -o MyEPG.json MyEPG.xml

# Parse

python MyEPG.py MyEPG.json

# Store

cp epg.v2.sqlite.db epg.v2.sqlite

zip -u epg.v2.sqlite.zip epg.v2.sqlite

cp epg.v2.sqlite.zip /var/www
