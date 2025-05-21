#!/bin/bash

# Paths
BIN_DIR="/proj/uppmax2025-3-3/nobackup/tobia/03_binning"
COUNTS_FILE="/home/tobia/Genome_analysis/ga_analyses/03_counts/gene_counts.txt"
OUT_FILE="/home/tobia/Genome_analysis/ga_analyses/03_counts/bin_expression_summary.tsv"
TMP_MAP="contig_to_bin.tsv"

# Create contig → bin map
> "$TMP_MAP"
for BIN in "$BIN_DIR"/bin.*.fa; do
  BIN_NAME=$(basename "$BIN" .fa)
  grep "^>" "$BIN" | sed 's/>//' | while read contig; do
    echo -e "${contig}\t${BIN_NAME}"
  done
done > "$TMP_MAP"

# Map expression to bins
echo -e "Bin\tTotal_Counts" > "$OUT_FILE"
awk 'NR==FNR { map[$1]=$2; next } FNR > 2 { bin=map[$1]; count[$1]=$2; bin_count[bin]+=$2 }
END { for (b in bin_count) print b, bin_count[b] }' OFS='\t' "$TMP_MAP" "$COUNTS_FILE" >> "$OUT_FILE"

echo "Bin-level expression summary saved to $OUT_FILE"
