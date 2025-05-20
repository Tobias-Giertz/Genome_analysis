#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 04:00:00
#SBATCH -J checkm_bins
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/checkm-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/checkm-%j.err

# Load modules
module load bioinfo-tools
module load CheckM/1.1.3

# Set CheckM DB path
checkm data setRoot /proj/uppmax2025-3-3/nobackup/tobia/checkm_db/2015_01_16

# Define paths
BINS_DIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/04_2_checkm
TMP_BINS_DIR=$OUTDIR/checkm_input
SUMMARY_TSV=/home/tobia/Genome_analysis/ga_analyses/04_quality_control/checkm_bin_summary.tsv

# Create output and temp input dirs
mkdir -p $OUTDIR
mkdir -p $TMP_BINS_DIR

# Symlink renamed bins to avoid CheckM issues with "." in filenames
for f in $BINS_DIR/bin.*.fa; do
    base=$(basename "$f")
    newname=$(echo "$base" | sed 's/bin\.\([0-9]*\)\.fa/bin_\1.fa/')
    ln -sf "$f" "$TMP_BINS_DIR/$newname"
done

# Run CheckM lineage workflow
checkm lineage_wf -x fa -t 4 --reduced_tree $TMP_BINS_DIR $OUTDIR

# Run CheckM QA to summarize bin quality
checkm qa --tab_table -o 2 -f checkm_bin_summary.tsv lineage.ms storage

