#!/bin/bash

echo $0 $@
if test $# -ne 3 ; then
  echo argument error
  echo  $0 input.md output.md
  exit 11
fi

INPUT_MD=$1
OUTPUT_MD=$2
EXT=$3
TMP_MD=${INPUT_MD}.tmp
echo $1 --> $2

# html形式で貼り付けている画像をmarkdown形式に変換する
if test $EXT = "eps" ; then
  cat ${INPUT_MD} | sed -e "s/^<\/*div.\+//g" | sed -e "s/^<br.\+//g"  | sed -e "s/^<img src=\"\([a-zA-Z0-9_\.\/]\+\)\".\+<br>\(.\+\)<br>/![\2](\1)/g" > ${TMP_MD}
  cat ${TMP_MD} | sed -e "s/jpg/${EXT}/g" | sed -e "s/png/${EXT}/g" | sed -e "s/JPG/${EXT}/g" | sed -e "s/eps/${EXT}/g" > ${OUTPUT_MD}
  rm ${TMP_MD}
fi

if test $EXT = "PNG" ; then
  cat ${INPUT_MD} | sed -e "s/jpg/${EXT}/g" | sed -e "s/png/${EXT}/g" | sed -e "s/JPG/${EXT}/g" | sed -e "s/eps/${EXT}/g" > ${TMP_MD}
  cat ${TMP_MD} | sed -e "s/png\"/png\" width=\"480px\"/g" > ${OUTPUT_MD}
  rm ${TMP_MD}
fi

