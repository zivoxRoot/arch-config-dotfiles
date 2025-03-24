#/bin/sh

for filename in $(\ls ./images/*.jpg 2>/dev/null | xargs -n1 basename); do
	magick ./images/$filename -strip -thumbnail 500x500^ -gravity center -extent 500x500 ./cache/$filename
done
