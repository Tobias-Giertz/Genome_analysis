#!/bin/bash

# Script to count the number of reads in a gzipped FASTQ file
# Usage: ./count_reads.sh file.fastq.gz

if [ $# -ne 1 ]; then
  echo "Usage: $0 <file.fastq.gz>"
  exit 1
fi

FILE=$1

if [[ ! -f $FILE ]]; then
  echo "File not found!"
  exit 2
fi

# Each read takes up 4 lines in a FASTQ file
COUNT=$(zcat "$FILE" | wc -l)
READS=$((COUNT / 4))

echo "File: $FILE"
echo "Number of reads: $READS"
