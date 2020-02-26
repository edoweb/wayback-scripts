#!/bin/bash
# ***************************************************************************
# Automatisches Indexieren neuer Webschnitte
# Autor: Kuss, 19.02.2020 
#        für neue, auf edoweb-test geharvestete Webschnitte (nur diese)
# ***************************************************************************
collection_lesesaal=/opt/regal/openwayback-data/lesesaal
collection_weltweit=/opt/regal/openwayback-data/weltweit
owb_verz=/opt/regal/openwayback
logfile=/opt/regal/logs/ks.auto_add_test.log
data_basedir=/opt/regal
echo "" >> $logfile
echo "********************************************************************************" >> $logfile
echo `date`
echo `date` >> $logfile
echo "START Auto adding new web harvests of edoweb-test"
echo "START Auto adding new web harvests of edoweb-test" >> $logfile
echo "********************************************************************************" >> $logfile

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new wpull harvests" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 1. wpull-data
# Schleife über alle von wpull angelegten WARC-Dateien
dataverz=$data_basedir/wpull-data
cd $dataverz
for warcfile in edoweb:*/20*/*.warc.gz; do
  # echo "warcfile=$dataverz/$warcfile" >> $logfile
  cdxindex=`echo $warcfile | sed 's/\.warc\.gz$/.cdx/'`
  # Gibt es in der Sammlung schon einen CDX-Index zu dieser WARC-Datei ?
  if [ -f $collection_lesesaal/cdx-dateien/$cdxindex ]; then
    # echo "Indexdatei existiert" >> $logfile
    # Ist der Index neuer ?
    if test `find $collection_lesesaal/cdx-dateien/$cdxindex -prune -newer $warcfile`; then
      # echo "Indexdatei ist neuer. Nichts zu tun." >> $logfile
      continue
    fi
    echo "Indexdatei ist älter" >> $logfile
    # Indexdatei löschen
    rm $collection_lesesaal/cdx-dateien/$cdxindex
  fi

  # Indexdatei exsitiert noch nicht oder ist älter
  echo "warcfile=$dataverz/$warcfile" >> $logfile
  echo "Index wird erzeugt." >> $logfile
  # Erzeugt Indexdatei
  mkdir -p $collection_lesesaal/cdx-dateien/$cdxindex
  rmdir $collection_lesesaal/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warcfile $collection_lesesaal/cdx-dateien/$cdxindex >> $logfile
  cd $dataverz
done


echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new heritrix harvests" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 2. heritrix-data
# Schleife über alle von heritrix angelegten WARC-Dateien
dataverz=$data_basedir/heritrix-data
cd $dataverz
for warcfile in edoweb:*/20*/warcs/*.warc.gz; do
  # echo "warcfile=$dataverz/$warcfile" >> $logfile
  cdxindex=`echo $warcfile | sed 's/\.warc\.gz$/.cdx/'`
  # Gibt es in der Sammlung schon einen CDX-Index zu dieser WARC-Datei ?
  if [ -f "$collection_lesesaal/cdx-dateien/$cdxindex" ]; then
    # echo "Indexdatei existiert" >> $logfile
    # Ist der Index neuer ?
    if test `find "$collection_lesesaal/cdx-dateien/$cdxindex" -prune -newer $warcfile`; then
      # echo "Indexdatei ist neuer. Nichts zu tun." >> $logfile
      continue
    fi
    echo "Indexdatei ist älter" >> $logfile
    # Indexdatei löschen
    rm "$collection_lesesaal/cdx-dateien/$cdxindex"
  fi

  # Indexdatei exsitiert noch nicht oder ist älter
  echo "warcfile=$dataverz/$warcfile" >> $logfile
  echo "Index wird erzeugt." >> $logfile
  # Erzeugt Indexdatei
  mkdir -p $collection_lesesaal/cdx-dateien/$cdxindex
  rmdir "$collection_lesesaal/cdx-dateien/$cdxindex"
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warcfile "$collection_lesesaal/cdx-dateien/$cdxindex" >> $logfile
  cd $dataverz
done


# 3. cdn-data
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new cdn harvests in restricted access collection" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 3.1 Schleife über alle von CDN-Servern heruntergeladenen WARC-Dateien zur Indexierung in der Lesesaal-Sammlung
dataverz=$data_basedir/cdn-data
cd $dataverz
for warcfile in edoweb_cdn:*/20*/*.warc.gz; do
  # echo "warcfile=$dataverz/$warcfile" >> $logfile
  cdxindex=`echo $warcfile | sed 's/\.warc\.gz$/.cdx/'`
  # Gibt es in der Sammlung Lesesaal schon einen CDX-Index zu dieser WARC-Datei ?
  if [ -f $collection_lesesaal/cdx-dateien/$cdxindex ]; then
    # echo "Indexdatei existiert" >> $logfile
    # Ist der Index neuer ?
    if test `find $collection_lesesaal/cdx-dateien/$cdxindex -prune -newer $warcfile`; then
      # echo "Indexdatei ist neuer. Nichts zu tun." >> $logfile
      continue
    fi
    echo "Indexdatei ist älter" >> $logfile
    # Indexdatei löschen
    rm $collection_lesesaal/cdx-dateien/$cdxindex
  fi

  # Indexdatei exsitiert noch nicht oder ist älter
  echo "warcfile=$dataverz/$warcfile" >> $logfile
  echo "Index wird erzeugt." >> $logfile
  # Erzeugt Indexdatei
  mkdir -p $collection_lesesaal/cdx-dateien/$cdxindex
  rmdir $collection_lesesaal/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warcfile $collection_lesesaal/cdx-dateien/$cdxindex >> $logfile
  cd $dataverz
done

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new cdn harvests in public collection" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 3.2 Schleife über alle von CDN-Servern heruntergeladenen WARC-Dateien zur Indexierung in der öffentlichen Sammlung
dataverz=$data_basedir/cdn-data
cd $dataverz
for warcfile in edoweb_cdn:*/20*/*.warc.gz; do
  # echo "warcfile=$dataverz/$warcfile" >> $logfile
  cdxindex=`echo $warcfile | sed 's/\.warc\.gz$/.cdx/'`
  # Gibt es in der öffentlichen Sammlung schon einen CDX-Index zu dieser WARC-Datei ?
  if [ -f $collection_weltweit/cdx-dateien/$cdxindex ]; then
    # echo "Indexdatei existiert" >> $logfile
    # Ist der Index neuer ?
    if test `find $collection_weltweit/cdx-dateien/$cdxindex -prune -newer $warcfile`; then
      # echo "Indexdatei ist neuer. Nichts zu tun." >> $logfile
      continue
    fi
    echo "Indexdatei ist älter" >> $logfile
    # Indexdatei löschen
    rm "$collection_weltweit/cdx-dateien/$cdxindex"
  fi

  # Indexdatei exsitiert noch nicht oder ist älter
  echo "warcfile=$dataverz/$warcfile" >> $logfile
  echo "Index wird erzeugt." >> $logfile
  # Erzeugt Indexdatei
  mkdir -p $collection_weltweit/cdx-dateien/$cdxindex
  rmdir $collection_weltweit/cdx-dateien/$cdxindex
  cd $owb_verz
  bin/cdx-indexer $dataverz/$warcfile $collection_weltweit/cdx-dateien/$cdxindex >> $logfile
  cd $dataverz
done

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new public harvests (soft links)" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 4. public-data
# Schleife über alle WARC-Dateien (Links) in public-data
dataverz=$data_basedir/public-data
cd $dataverz
for warcfile in edoweb:*/20*/*.warc.gz edoweb:*/20*/warcs/*.warc.gz; do
  # echo "warcfile=$dataverz/$warcfile" >> $logfile
  cdxindex=`echo $warcfile | sed 's/\.warc\.gz$/.cdx/'`
  # Gibt es in der Weltweit-Sammlung schon einen CDX-Index zu dieser WARC-Datei ?
  if [ -f $collection_weltweit/cdx-dateien/$cdxindex ]; then
    # echo "Indexdatei existiert" >> $logfile
    # Ist der Index neuer ?
    if test `find $collection_weltweit/cdx-dateien/$cdxindex -prune -newer $warcfile`; then
      # echo "Indexdatei ist neuer. Nichts zu tun." >> $logfile
      continue
    fi
    echo "Indexdatei ist älter" >> $logfile
    # Indexdatei löschen
    rm $collection_weltweit/cdx-dateien/$cdxindex
  fi

  # Indexdatei exsitiert noch nicht oder ist älter
  echo "warcfile=$dataverz/$warcfile" >> $logfile
  echo "Index wird erzeugt." >> $logfile
  # Erzeugt Indexdatei durch Kopieren der Indexdatei vom Lesesaal
  mkdir -p $collection_weltweit/cdx-dateien/$cdxindex
  rmdir $collection_weltweit/cdx-dateien/$cdxindex
  cp $collection_lesesaal/cdx-dateien/$cdxindex $collection_weltweit/cdx-dateien/$cdxindex >> $logfile
  cd $dataverz
done

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START merge and sort indexes" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 5.1
cd /opt/regal/wayback-scripts
./ks.merge-sort-cdx-indexes.sh lesesaal >> $logfile
# 5.2
cd /opt/regal/wayback-scripts
./ks.merge-sort-cdx-indexes.sh weltweit >> $logfile

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START creating path index" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# 6.1
cd /opt/regal/wayback-scripts
./ks.create-path-index-lesesaal.sh >> $logfile
# 6.2
cd /opt/regal/wayback-scripts
./ks.create-path-index-weltweit.sh >> $logfile

echo "********************************************************************************" >> $logfile
echo `date`
echo `date` >> $logfile
echo "ENDE Auto adding new web harvests of edoweb-test"
echo "ENDE Auto adding new web harvests of edoweb-test" >> $logfile
echo "********************************************************************************" >> $logfile
exit 0
