#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 20:00:00
#SBATCH -J functional_eggnog
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/functional_eggnog-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/functional_eggnog-%j.err

# Load modules
module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# Input and output directories
INPUT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/06_annotations
OUTPUT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog
DATA_DIR=/sw/data/eggNOG_data/5.0.0/rackham

# Loop through all Prokka-annotated .faa files
for faa in ${INPUT_DIR}/bin_*_prokka/*.faa; do
    BASENAME=$(basename "$faa" _annotation.faa)
    OUT_SUBDIR=${OUTPUT_DIR}/${BASENAME}_eggnog
    mkdir -p "$OUT_SUBDIR"

    # Skip if already annotated
    if [[ -f "${OUT_SUBDIR}/${BASENAME}_emapper.emapper.annotations" ]]; then
        echo "Skipping $BASENAME (already annotated)"
        continue
    fi

    echo "Running eggNOG-mapper on $BASENAME"

    emapper.py -i "$faa" \
      -o "${BASENAME}_emapper" \
      --output_dir "$OUT_SUBDIR" \
      --cpu 4 \
      --data_dir "$DATA_DIR" \
      --itype proteins
done
