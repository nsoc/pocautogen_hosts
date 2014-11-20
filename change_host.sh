#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Usage: $0 TO_HOST FROM_HOST"
  exit 1
fi
TO_HOST=$1
FROM_HOST=$2

if [ "$STRICT" = "TRUE" ]; then
  for ENV_FILE in `ls setenv*`
  do
    TMP_LINE=""
  
    cat $ENV_FILE | while read LINE
    do
      TMP_LINE=`echo $LINE | sed -e "s/^$FROM_HOST\(:[^:]*\)\(:[^:]*\)/$TO_HOST\1\2/"`
      TMP_LINE=`echo $TMP_LINE | sed -e "s/^$FROM_HOST\(:[^:]*\)/$TO_HOST\1/"`
      echo $TMP_LINE >> ${ENV_FILE}_tmp
    done
    mv ${ENV_FILE}_tmp $ENV_FILE
  done
  
else
  for ENV_FILE in `ls setenv*`
  do
    TMP_LINE=""
  
    cat $ENV_FILE | while read LINE
    do
      TMP_LINE=`echo $LINE | sed -e "s/$FROM_HOST/$TO_HOST/"`
      TMP_LINE=`echo $TMP_LINE | sed -e "s/$FROM_HOST/$TO_HOST/"`
      echo $TMP_LINE >> ${ENV_FILE}_tmp
    done
    mv ${ENV_FILE}_tmp $ENV_FILE
  done

fi

for ENV_FILE in `ls confighost*`
do
  TMP_LINE=""

  cat $ENV_FILE | while read LINE
  do
    TMP_LINE=`echo $LINE | sed -e "s/$FROM_HOST/$TO_HOST/"`
    TMP_LINE=`echo $TMP_LINE | sed -e "s/$FROM_HOST/$TO_HOST/"`
    echo $TMP_LINE >> ${ENV_FILE}_tmp
  done
  mv ${ENV_FILE}_tmp $ENV_FILE
done

