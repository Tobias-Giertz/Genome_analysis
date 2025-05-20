#!/bin/bash

# Define the target directory and output file
TARGET_DIR="/domus/h1/tobia/Genome_analysis/ga_code"
OUTPUT_FILE="all_scripts_combined.txt"

# Empty or create the output file
> "$OUTPUT_FILE"

# Loop through each relevant file type
for file in "$TARGET_DIR"/*.{sh,R,py}; do
    if [[ -f "$file" ]]; then
        filename=$(basename -- "$file")
        extension="${filename##*.}"

        # Determine the code block language
        case "$extension" in
            sh) lang="bash" ;;
            R)  lang="r" ;;
            py) lang="python" ;;
            *)  lang="text" ;;
        esac

        # Append formatted content to output file
        {
            echo "### [$filename]"
            echo "\`\`\`$lang"
            cat "$file"
            echo "\`\`\`"
            echo ""
        } >> "$OUTPUT_FILE"
    fi
done

echo "Scripts have been combined into: $OUTPUT_FILE"
