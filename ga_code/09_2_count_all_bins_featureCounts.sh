#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J featureCounts_all_bins
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=ga_code/ga_slurm_logs/featureCounts_all_bins-%j.out
#SBATCH --error=ga_code/ga_slurm_logs/featureCounts_all_bins-%j.err

# Load modules
module load bioinfo-tools
module load subread

# Define paths
ANNOT_DIR=/domus/h1/tobia/Genome_analysis/ga_analyses/06_annotations
ALIGNMENT=/home/tobia/Genome_analysis/ga_analyses/02_alignment/SRR4342137_sorted.bam
OUTDIR=/home/tobia/Genome_analysis/ga_analyses/03_counts
mkdir -p "$OUTDIR"

# Loop over all Prokka GFF files
for GFF in "$ANNOT_DIR"/bin_*_prokka/bin_*_annotation.gff; do
    BIN=$(basename "$(dirname "$GFF")")  # e.g., bin_3_prokka
    BIN_NAME=${BIN%_prokka}              # e.g., bin_3
    OUTFILE="$OUTDIR/${BIN_NAME}_counts.txt"

    echo "Counting reads for $BIN_NAME → $OUTFILE"

    featureCounts -T 2 -p -B -C \
      -a "$GFF" -t CDS -g ID \
      -o "$OUTFILE" "$ALIGNMENT"
done
