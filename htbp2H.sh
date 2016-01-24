#!/bin/bash

echo $0 $@
if test $# -ne 2 ; then
  echo argument error
  echo  $0 input.md output.md
  exit 11
fi

INPUT_TEX=$1
OUTPUT_TEX=$2
echo $1 --> $2

cat ${INPUT_TEX} | sed -e "s/htbp/H/g" > ${OUTPUT_TEX}

