heap_analyze.sh $1 | grep $2 | awk -F" " 'BEGIN{}{total=total+$1}END{printf"total %ld\n", total}'
