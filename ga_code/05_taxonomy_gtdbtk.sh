#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH --mem=64G
#SBATCH -t 01:30:00
#SBATCH -J gtdbtk_phylogeny
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/gtdbtk-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/gtdbtk-%j.err

# Load GTDB-Tk module
module load bioinfo-tools
module load GTDBTk/2.1.1

# Fix for missing dependencies (in case needed — safe to include)
export PATH=/sw/bioinfo/hmmer/3.4/src/hmmer-3.4/src:$PATH
export PATH=/sw/bioinfo/pplacer/1.1.alpha19/snowy/bin:$PATH
export PATH=/sw/bioinfo/fastani/1.32/snowy/bin:$PATH

# Input directory with selected bins (6 MAGs)
INPUT_DIR=/proj/uppmax2025-3-3/nobackup/tobia/06_gtdbtk_input

# Output directory
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/06_gtdbtk_out
mkdir -p $OUTDIR

# Run GTDB-Tk classify workflow
gtdbtk classify_wf --genome_dir $INPUT_DIR --out_dir $OUTDIR --cpus 16
