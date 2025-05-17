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

# Load eggNOG-mapper
module load bioinfo-tools
module load eggNOG-mapper/2.1.9

# Define input and output
INPUT=/domus/h1/tobia/Genome_analysis/ga_analyses/06_annotations/bin_3_prokka/bin_3_annotation.faa
OUTDIR=/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog/bin_3_eggnog

# Run eggNOG-mapper
emapper.py -i "$INPUT" \
  -o bin_3_emapper \
  --output_dir "$OUTDIR" \
  --cpu 2 \
  --data_dir /sw/data/eggNOG_data/5.0.0/rackham \
  --itype proteins
