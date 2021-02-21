file=static/palavras/palavras.txt

for i in `cat $file`
do
  # add your logic here
  echo "$i" | iconv -t ascii//TRANSLIT | sed -r s/[^a-zA-Z0-9]+/-/g | sed -r s/^-+\|-+$//g | tr A-Z a-z
done