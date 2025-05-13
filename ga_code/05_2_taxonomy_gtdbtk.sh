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

# Load GTDB-Tk from UPPMAX modules
module load bioinfo-tools
module load GTDB-Tk/2.4.0

# Set GTDB reference database
export GTDBTK_DATA_PATH=/proj/uppmax2025-3-3/nobackup/tobia/gtdbtk_data/release207

# Add HMMER binaries to path
export PATH=/sw/bioinfo/hmmer/3.4/src/hmmer-3.4/src:$PATH

# Define input and output
INPUT_DIR=/home/tobia/Genome_analysis/ga_analyses/05_selected_bins/top_bins_fa
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/05_gtdbtk
mkdir -p $OUTDIR

# Run GTDB-Tk
gtdbtk classify_wf --genome_dir $INPUT_DIR --out_dir $OUTDIR --cpus 16
