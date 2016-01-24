#!/bin/bash

for ext in png jpg PNG JPG; do
  echo $ext
  find . | grep -e ${ext}$ | sed -e "s/....$//g" | xargs -n1 -i{} convert -density 300 -resize 960 {}.${ext} {}.eps
done

#find . | grep -e png$ | sed -e "s/....$//g" | xargs -n1 -i{} convert -density 600 -resize 480 {}.png {}.eps
#find . | grep -e jpg$ | sed -e "s/....$//g" | xargs -n1 -i{} convert -density 600 -resize 480 {}.jpg {}.eps

