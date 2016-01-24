#!/bin/bash

echo $?
#if $? -eq 1; then
#  pushd image
#  #bash convert.sh
#  popd
#fi

# html形式で貼り付けている画像をmarkdown形式に変換する
cat 2015_winter.md | sed -e "s/^<\/*div.\+//g" | sed -e "s/^<br.\+//g"  | sed -e "s/^<img src=\"\([a-zA-Z0-9_\.\/]\+\)\".\+<br>\(.\+\)<br>/![\2](\1)/g" > tmp.md
cat tmp.md | sed -e "s/jpg/eps/g" | sed -e "s/png/eps/g" | sed -e "s/JPG/eps/g" > tmp2.md

cat tex_header.tex > 2015_winter.tex 
#pandoc -t latex 2015_winter.md >> 2015_winter.tex
pandoc -t latex tmp2.md >> 2015_winter.tex
cat tex_bibitem.tex >> 2015_winter.tex
pandoc -t latex 2015_winter_afterword.md >> 2015_winter.tex
cat tex_hooter.tex >> 2015_winter.tex 

cat 2015_winter.tex | sed -e "s/htbp/H/g" > tmp.tex

platex -kanji=utf8 tmp.tex 
dvipdf tmp.dvi
cp tmp.pdf 2015_winter.pdf
gnome-open 2015_winter.pdf

