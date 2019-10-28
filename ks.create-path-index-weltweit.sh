#!/bin/bash
# Erzeuge path-index.txt - Datei für die Weltweit-Sammlung
# für public-data + cdn-data
echo "collection: weltweit_cdx"
collection_verz=/opt/regal/openwayback-data/weltweit_cdx
ls /data2/public-data/edoweb:*/20*/*.warc.gz  /data2/public-data/edoweb:*/20*/warcs/*.warc.gz  /data2/cdn-data/edoweb_cdn:*/20*/*.warc.gz | sed 's/^.*\/\([^\/]*\.warc\.gz\)$/\1\t\0/' > $collection_verz/path-index.001.txt
cd $collection_verz
# Sortieren:
export LC_ALL=C;
cat path-index.001.txt | sort -u > path-index.sorted.txt;
mv path-index.sorted.txt path-index.001.txt
XGH path-index.txt
mv path-index.001.txt path-index.txt
