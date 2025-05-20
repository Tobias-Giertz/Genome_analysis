#!/bin/bash
ANNOT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog
OUTDIR=${ANNOT_DIR}/summaries
mkdir -p $OUTDIR

for ANN in $ANNOT_DIR/bin_*_eggnog/*_emapper.emapper.annotations; do
    BIN=$(basename "$ANN" _emapper.emapper.annotations)
    OUT=$OUTDIR/${BIN}_ko.txt

    grep -v "^#" "$ANN" | cut -f6 | tr ',' '\n' | grep "^K" | sort -u > "$OUT"
    echo "Extracted KO list: $OUT"
done
