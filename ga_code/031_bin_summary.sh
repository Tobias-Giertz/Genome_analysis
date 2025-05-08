#!/bin/bash

# Directory containing your bins
BIN_DIR="/proj/uppmax2025-3-3/nobackup/tobia/03_binning"

# Output summary file
OUTFILE="$BIN_DIR/bin_summary.tsv"
echo -e "Bin\tContigs\tTotal_bp\tLongest_bp" > $OUTFILE

# Loop through all bin files
for BIN in $BIN_DIR/bin.*.fa; do
    BIN_NAME=$(basename "$BIN")
    CONTIGS=$(grep -c "^>" "$BIN")
    TOTAL_BP=$(awk '/^>/ {if (seqlen){print seqlen}; seqlen=0; next} {seqlen += length($0)} END {print seqlen}' "$BIN" | awk '{sum+=$1} END {print sum}')
    LONGEST_BP=$(awk '/^>/ {if (seqlen){print seqlen}; seqlen=0; next} {seqlen += length($0)} END {print seqlen}' "$BIN" | sort -nr | head -1)
    echo -e "$BIN_NAME\t$CONTIGS\t$TOTAL_BP\t$LONGEST_BP" >> $OUTFILE
done

echo "Summary written to $OUTFILE"
