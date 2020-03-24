#/bin/bash
echo "****************************************************************"
echo `date`
echo "Indexiere alle WARCS unter cdn-data, je eine .cdx-Datei pro WARC"
echo "****************************************************************"
collection=$1
if [ ! $1 ] ; then
  echo "Bitte eine Sammlung angeben ! (z.B. lesesaal, weltweit, ...)"
  exit 0
fi
echo "collection: $collection"
logdatei=/opt/wayback/logs/cdxindexer.log # bitte Ausgabe hierhin umleiten
dataverz=/data2/cdn-data
owb_verz=/opt/wayback/openwayback
collection_verz=/opt/wayback/openwayback-data/$collection
cd $dataverz
for warc in `ls edoweb_cdn:*/20*/*.warc.gz` ; do
  echo "warc=$warc"
  cdxindex=`echo $warc | sed 's/\.warc\.gz$/.cdx/'`
  echo "cdxindex=$cdxindex"
  mkdir -p $collection_verz/cdx-dateien/$cdxindex
  rmdir $collection_verz/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warc $collection_verz/cdx-dateien/$cdxindex
  cd $dataverz
done

echo "****************************************************************"
echo `date`
echo "fertig."
echo "****************************************************************"

exit 0
