#!/bin/bash

ANNOT_DIR="/domus/h1/tobia/Genome_analysis/ga_analyses/06_annotations"
OUTFILE="${ANNOT_DIR}/prokka_summary.tsv"

# Header
echo -e "Bin\tContigs\tBases\tCDS\ttRNA" > "$OUTFILE"

# Loop through annotation result folders
for dir in "$ANNOT_DIR"/bin_*_prokka; do
    bin_name=$(basename "$dir" _prokka)
    txt_file="${dir}/${bin_name}_annotation.txt"

    if [[ -f "$txt_file" ]]; then
        contigs=$(grep -i '^contigs:' "$txt_file" | awk '{print $2}')
        bases=$(grep -i '^bases:' "$txt_file" | awk '{print $2}')
        cds=$(grep -i '^CDS:' "$txt_file" | awk '{print $2}')
        trna=$(grep -i '^tRNA:' "$txt_file" | awk '{print $2}')
        echo -e "${bin_name}\t${contigs}\t${bases}\t${cds}\t${trna}" >> "$OUTFILE"
    fi
done

echo "Summary written to: $OUTFILE"
