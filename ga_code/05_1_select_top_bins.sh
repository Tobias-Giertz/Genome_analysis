#!/bin/bash

# Input CheckM summary file
SUMMARY=/home/tobia/Genome_analysis/ga_analyses/04_quality_control/checkm_bin_summary.tsv
OUTFILE=/home/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins.tsv

mkdir -p $(dirname "$OUTFILE")

# Filter bins based on quality criteria
awk -F '\t' 'NR==1 || ($6 >= 70 && $7 <= 10)' "$SUMMARY" > "$OUTFILE"

echo "Selected top bins saved to $OUTFILE"

TOPBINS=/home/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins.tsv
ALLBINS=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
OUTDIR=/home/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins_fa

mkdir -p "$OUTDIR"

tail -n +2 "$TOPBINS" | cut -f1 | while read bin_id; do
    src="$ALLBINS/${bin_id/bin_/bin.}.fa"
    dst="$OUTDIR/${bin_id}.fa"
    cp "$src" "$dst" && echo "Copied $src → $dst"
done

