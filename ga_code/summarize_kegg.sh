#!/bin/bash

# Directory containing eggNOG annotation files
ANNOT_DIR="/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog"
OUT_DIR="$ANNOT_DIR/summaries"
mkdir -p "$OUT_DIR"

KEGG_OUT="$OUT_DIR/kegg_summary.tsv"
echo -e "Bin\tKEGG_KO\tCount" > "$KEGG_OUT"

# Loop through annotation files
for FILE in "$ANNOT_DIR"/bin_*_eggnog/*.annotations; do
  BIN=$(basename "$(dirname "$FILE")" _eggnog)

  awk -F '\t' -v bin="$BIN" '
    BEGIN { OFS="\t" }
    !/^#/ && $12 != "" {
      split($12, ko, ",");
      for (i in ko) {
        count[ko[i]]++;
      }
    }
    END {
      for (k in count) {
        print bin, k, count[k];
      }
    }
  ' "$FILE" >> "$KEGG_OUT"
done

echo "KEGG summary written to $KEGG_OUT"
