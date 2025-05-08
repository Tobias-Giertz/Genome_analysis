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

# Define paths
BINS_DIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/04_2_checkm
mkdir -p $OUTDIR

# Run CheckM lineage_wf (automated quality assessment)
checkm lineage_wf -x fa -t 4 --reduced_tree $BINS_DIR $OUTDIR
