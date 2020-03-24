#!/bin/bash
# Erzeuge path-index.txt - Datei für die Weltweit-Sammlung
# für public-data + cdn-data
echo "collection: weltweit"
collection_verz=/opt/wayback/openwayback-data/weltweit
ls /data2/public-data/edoweb:*/20*/*.warc.gz  /data2/public-data/edoweb:*/20*/warcs/*.warc.gz  /data2/cdn-data/edoweb_cdn:*/20*/*.warc.gz | sed 's/^.*\/\([^\/]*\.warc\.gz\)$/\1\t\0/' > $collection_verz/path-index.001.txt
cd $collection_verz
# Sortieren:
export LC_ALL=C;
cat path-index.001.txt | sort -u > path-index.sorted.txt;
mv path-index.sorted.txt path-index.001.txt
# Hier Historienstände rotieren und ältesten wegschmeißen
cd weltweit.HIST/
rm path-index.txt.7
N=7
M=6
while [ $M -gt 0 ]; do
   # echo Zeile $N
    mv path-index.txt.$M path-index.txt.$N
   ((N--))
   ((M--))
done
cd ..
mv path-index.txt weltweit.HIST/path-index.txt.1
mv path-index.001.txt path-index.txt
