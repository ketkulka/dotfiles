#! /bin/bash
echo""
echo "Heap allocations for $2:"
cat $1 | grep -A1 "bytes"|  grep -B1 "$2" |awk '{if($5 !=""){print $1 "\t" $5 "\t" $2"\t" $3} else {print $1 "\t(0" "\t" $2 "\t" $3}}' | grep -v "\-\-" | sed 'N;s/\n/  /' | sed 's/(//' | awk '{printf("%ld\t= (%d * %d)  at: %s %s\n", ($1 * ($2+1)), $1 , ($2+1), $7, $8);}'
