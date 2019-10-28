#/bin/bash
echo "*********************************************************************"
echo `date`
echo "Indexiere alle WARCS unter public-data, je eine .cdx-Datei pro WARC"
echo "*********************************************************************"
logdatei=/opt/regal/logs/cdxindexer.log # bitte Ausgabe hierhin umleiten
dataverz=/data2/public-data
owb_verz=/opt/regal/openwayback
collection_verz=/opt/regal/openwayback-data/weltweit_cdx
cd $dataverz
for warc in `ls edoweb:*/20*/*.warc.gz edoweb:*/20*/warcs/*.warc.gz`; do
  echo "warc=$warc"
  cdxindex=`echo $warc | sed 's/\.warc\.gz$/.cdx/'`
  echo "cdxindex=$cdxindex"
  mkdir -p $collection_verz/cdx-dateien/$cdxindex
  rmdir $collection_verz/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warc $collection_verz/cdx-dateien/$cdxindex
  cd $dataverz
done

echo "*****************************************************************"
echo `date`
echo "fertig."
echo "*****************************************************************"

exit 0