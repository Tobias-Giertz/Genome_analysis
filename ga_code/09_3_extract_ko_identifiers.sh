#!/bin/bash
ANNOT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog
OUTDIR=${ANNOT_DIR}/summaries
mkdir -p $OUTDIR

for ANN in $ANNOT_DIR/bin_*_eggnog/*_emapper.emapper.annotations; do
    BIN=$(basename "$ANN" _emapper.emapper.annotations)
    OUT=$OUTDIR/${BIN}_ko.txt

    # Extract from column 12 (KEGG_ko), ignore empty fields
    awk -F '\t' 'BEGIN{OFS="\n"} !/^#/ && $12 != "-" {split($12, a, ","); for (i in a) print a[i]}' "$ANN" | sort -u > "$OUT"

    echo "Extracted KO list: $OUT"
done
