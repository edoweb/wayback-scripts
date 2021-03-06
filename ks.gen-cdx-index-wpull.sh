#/bin/bash
echo "******************************************************************"
echo `date`
echo "Indexiere alle WARCS unter wpull-data, je eine .cdx-Datei pro WARC"
echo "******************************************************************"
dataverz=/data2/wpull-data
owb_verz=/opt/wayback/openwayback
collection_verz=/opt/wayback/openwayback-data/lesesaal_cdx
cd $dataverz
logdatei=/opt/wayback/logs/cdxindexer.log # bitte Ausgabe hierhin umleiten
# for warc in `find . -name "*.warc.gz"`; do # dauert zu lange
for warc in `ls edoweb:*/20*/*.warc.gz`; do
  echo "warc=$warc"
  cdxindex=`echo $warc | sed 's/\.warc\.gz$/.cdx/'`
  echo "cdxindex=$cdxindex"
  mkdir -p $collection_verz/cdx-dateien/$cdxindex
  rmdir $collection_verz/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warc $collection_verz/cdx-dateien/$cdxindex
  cd $dataverz
done

exit 0
