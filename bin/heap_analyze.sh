cat $1 | sed 's/[ ]*from/from/g' | sed 'N; s/\n/ /' | sed 's/\([^)]\) from/\1 (1 similar) from/g' | awk '{b=$1; n=gensub("\\(", "", 1, $5); printf "%12d -> %s\n", b*n, $0}' | sort -nr
