#!/bin/bash
# Merge and Sort der erzeugten .cdx-Dateien
# erzeugt index001.cdx
collection=$1
if [ ! $1 ] ; then
  echo "Bitte eine Sammlung angeben ! (z.B. lesesaal, weltweit, ...)"
  exit 0
fi
echo "collection: $collection"
cd /opt/regal/openwayback-data/$collection
export LC_ALL=C;
# merge indexes from wpull-data, cdn-data, heritrix-data and wget-data
if [ ! -d "cdx-index" ]; then mkdir cdx-index; fi
cat cdx-dateien/edoweb:*/20*/*.cdx cdx-dateien/edoweb_cdn:*/20*/*.cdx cdx-dateien/edoweb:*/20*/warcs/*.cdx > cdx-index/index001.cdx
cd cdx-index/
cat index001.cdx | sort -u > index.tmp.cdx
mv index.tmp.cdx index001.cdx
# Hier Historienstände rotieren und ältesten wegschmeißen
cd cdx-index.HIST/
rm index.cdx.5
N=5
M=4
while [ $M -gt 0 ]; do
   # echo Zeile $N
    mv index.cdx.$M index.cdx.$N
   ((N--))
   ((M--))
done
cd ..
mv index.cdx cdx-index.HIST/index.cdx.1
mv index001.cdx index.cdx
