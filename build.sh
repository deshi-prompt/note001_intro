#!/bin/bash

echo $?
#if $? -eq 1; then
#  pushd image
#  #bash convert.sh
#  popd
#fi

pushd image
bash convert.sh
popd

SRC_DIR=`pwd`/src
TEMPLATE_DIR=`pwd`/template
BUILD_DIR=`pwd`/build

# html形式で貼り付けている画像をmarkdown形式に変換する
cat ${SRC_DIR}/2015_winter.md | sed -e "s/^<\/*div.\+//g" | sed -e "s/^<br.\+//g"  | sed -e "s/^<img src=\"\([a-zA-Z0-9_\.\/]\+\)\".\+<br>\(.\+\)<br>/![\2](\1)/g" > ${BUILD_DIR}/tmp.md
cat ${BUILD_DIR}/tmp.md | sed -e "s/jpg/eps/g" | sed -e "s/png/eps/g" | sed -e "s/JPG/eps/g" > ${BUILD_DIR}/tmp2.md

mkdir -p ${BUILD_DIR}

cat ${TEMPLATE_DIR}/tex_header.tex > ${BUILD_DIR}/2015_winter.tex 
#pandoc -t latex 2015_winter.md >> 2015_winter.tex
pandoc -t latex ${BUILD_DIR}/tmp2.md >> ${BUILD_DIR}/2015_winter.tex
cat ${TEMPLATE_DIR}/tex_bibitem.tex >> ${BUILD_DIR}/2015_winter.tex
pandoc -t latex ${SRC_DIR}/2015_winter_afterword.md >> ${BUILD_DIR}/2015_winter.tex
cat ${TEMPLATE_DIR}/tex_hooter.tex >> ${BUILD_DIR}/2015_winter.tex 

cat ${BUILD_DIR}/2015_winter.tex | sed -e "s/htbp/H/g" > ${BUILD_DIR}/tmp.tex

platex -kanji=utf8 -output-directory=${BUILD_DIR} ${BUILD_DIR}/tmp.tex 
dvipdf ${BUILD_DIR}/tmp.dvi ${BUILD_DIR}/2015_winter.pdf
#cp tmp.pdf 2015_winter.pdf

gnome-open ${BUILD_DIR}/2015_winter.pdf

