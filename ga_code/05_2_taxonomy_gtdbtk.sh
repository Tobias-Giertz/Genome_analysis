#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH --mem=64G
#SBATCH -t 02:00:00
#SBATCH -J gtdbtk_phylogeny
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/gtdbtk-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/gtdbtk-%j.err

# Load conda
module load conda
conda activate /proj/uppmax2025-3-3/nobackup/tobia/envs/gtdbtk_env

# Define input/output
INPUT_DIR=/home/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins_fa
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/05_gtdbtk
mkdir -p $OUTDIR

# Run GTDB-Tk
gtdbtk classify_wf --genome_dir $INPUT_DIR --out_dir $OUTDIR --cpus 16


