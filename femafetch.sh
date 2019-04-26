#!/bin/bash

#for each id in the range of i below,
#prints the fema id, type, location, and date of disaster declarations, separated by |

#usage: bash femafetch
> fema.txt
echo "FEMA number | type | location | date declared"
for i in {1..5263}
do
  url="https://www.fema.gov/disaster/$i"
  page=$(curl -s $url)

  pagetitle=$(echo $page | grep -oP "(?<=\<title\>).*?(?=\</title\>)")

  fema_num=$(echo $pagetitle | grep -oP "(?<=\()..-\d*(?=\))")
#  type=$(echo $pagetitle | grep -oP "(?<=[a-z]\s)[A-Z][A-Z].*(?=\s\()")
#  location=$(echo $pagetitle | grep -oP "^[A-Z][a-z]*(?=\s[A-Z][A-Z])")
  typeloc=$(echo $pagetitle | grep -oP ".*(?=\(..-\d)")
  date=$(echo $page | grep -oP "(?<=Incident Period\: \<span class\=\"bold\"\>).*?(?=\<)")

  echo "$i | $fema_num | $typeloc | $date"
  echo "$i | $fema_num | $typeloc | $date" >> fema.txt
done
