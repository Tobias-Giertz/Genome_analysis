#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH --mem=8G
#SBATCH -t 01:00:00
#SBATCH -J functional_eggnog
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/quast-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/quast-%j.err

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
  --cpu 4 \
  --data_dir /sw/bioinfo/eggNOG-mapper/2.1.9/rackham/eggnog_data \
  --itype proteins
