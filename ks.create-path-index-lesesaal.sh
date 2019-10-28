#!/bin/bash
# Erzeuge path-index.txt - Datei für die Lesesaal-Sammlung
# für wpull-data + cdn-data + heritrix-data + wget-data
echo "collection: lesesaal_cdx"
collection_verz=/opt/regal/openwayback-data/lesesaal_cdx
ls /data2/wpull-data/edoweb:*/20*/*.warc.gz  /data2/cdn-data/edoweb_cdn:*/20*/*.warc.gz  /data2/heritrix-data/edoweb:*/20*/warcs/*.warc.gz  /opt/regal/wget-data/edoweb:*/20*/warcs/*.warc.gz | sed 's/^.*\/\([^\/]*\.warc\.gz\)$/\1\t\0/' > $collection_verz/path-index.001.txt
cd $collection_verz
# Sortieren:
export LC_ALL=C;
cat path-index.001.txt | sort -u > path-index.sorted.txt;
mv path-index.sorted.txt path-index.001.txt
XGH path-index.txt
mv path-index.001.txt path-index.txt
