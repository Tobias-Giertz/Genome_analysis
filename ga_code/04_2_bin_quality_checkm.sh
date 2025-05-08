#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 04:00:00
#SBATCH -J checkm_bins
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/checkm-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/checkm-%j.err

# Load CheckM
module load bioinfo-tools
module load CheckM/1.1.3

# Define paths
BINS_DIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
STORAGE_DIR=/proj/uppmax2025-3-3/nobackup/tobia/04_2_checkm/storage
OUTFILE=/proj/uppmax2025-3-3/nobackup/tobia/04_2_checkm/qa_results.tsv

# Step 1: Analyze bins (generate marker statistics)
checkm analyze -x fa --reduced_tree $STORAGE_DIR $BINS_DIR

# Step 2: Create quality summary table
checkm qa --tab_table -o 2 $STORAGE_DIR > $OUTFILE
