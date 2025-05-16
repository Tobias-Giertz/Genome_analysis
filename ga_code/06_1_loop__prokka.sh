#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=16G
#SBATCH -t 04:00:00
#SBATCH -J prokka_all_bins
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/prokka_all_bins-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/prokka_all_bins-%j.err

# Load modules
module load bioinfo-tools
module load prokka

# Define input and output base directories
INPUT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins_fa
OUTPUT_BASE=/domus/h1/tobia/Genome_analysis/ga_analyses/06_annotations

mkdir -p "$OUTPUT_BASE"

# Annotate each .fa file
for BIN in "$INPUT_DIR"/*.fa; do
    BASENAME=$(basename "$BIN" .fa)
    OUTDIR="${OUTPUT_BASE}/${BASENAME}_prokka"
    PREFIX="${BASENAME}_annotation"
    echo "Annotating $BIN → $OUTDIR"
    prokka --outdir "$OUTDIR" --prefix "$PREFIX" --cpus 4 "$BIN"
done
