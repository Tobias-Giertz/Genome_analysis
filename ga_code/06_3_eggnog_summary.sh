#!/bin/bash

# Set directory with annotation files
ANNOT_DIR="/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog"
OUT_DIR="$ANNOT_DIR/summaries"
mkdir -p "$OUT_DIR"

# Output files
COG_OUT="$OUT_DIR/cog_counts.tsv"
KEGG_OUT="$OUT_DIR/kegg_counts.tsv"
GO_OUT="$OUT_DIR/go_counts.tsv"

# Headers
echo -e "Bin\tCOG_Category\tCount" > "$COG_OUT"
echo -e "Bin\tKEGG_KO\tCount" > "$KEGG_OUT"
echo -e "Bin\tGO_Term\tCount" > "$GO_OUT"

# Process each bin
for FILE in "$ANNOT_DIR"/bin_*_eggnog/*.annotations; do
    BIN=$(basename "$(dirname "$FILE")" _eggnog)

    # COG
    awk -F '\t' -v bin="$BIN" 'BEGIN{OFS="\t"} !/^#/ && $11 != "" {
        split($11, cats, ",");
        for (i in cats) {
            count[cats[i]]++;
        }
    } END {
        for (c in count) print bin, c, count[c];
    }' "$FILE" >> "$COG_OUT"

    # KEGG
    awk -F '\t' -v bin="$BIN" 'BEGIN{OFS="\t"} !/^#/ && $12 != "" {
        split($12, kegg, ",");
        for (i in kegg) {
            count[kegg[i]]++;
        }
    } END {
        for (k in count) print bin, k, count[k];
    }' "$FILE" >> "$KEGG_OUT"

    # GO
    awk -F '\t' -v bin="$BIN" 'BEGIN{OFS="\t"} !/^#/ && $13 != "" {
        split($13, go, ",");
        for (i in go) {
            count[go[i]]++;
        }
    } END {
        for (g in count) print bin, g, count[g];
    }' "$FILE" >> "$GO_OUT"
done

echo "Annotation summaries written to $OUT_DIR"
