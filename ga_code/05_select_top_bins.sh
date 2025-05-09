#!/bin/bash

# Paths
QA_RESULTS=/proj/uppmax2025-3-3/nobackup/tobia/04_2_checkm/qa_results.tsv
BIN_DIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
OUT_DIR=/proj/uppmax2025-3-3/nobackup/tobia/06_gtdbtk_input

# Create output dir if needed
mkdir -p $OUT_DIR

# Filter and copy high-quality bins
awk -F '\t' 'NR>1 && $12 >= 90 && $13 < 5 {print $1}' $QA_RESULTS | while read BIN; do
    echo "Copying $BIN..."
    cp "$BIN_DIR/$BIN" "$OUT_DIR/"
done

echo "Done. High-quality bins copied to $OUT_DIR"
