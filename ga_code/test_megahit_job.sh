#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J test_megahit
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/test_megahit-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/test_megahit-%j.err

# Load modules
module load bioinfo-tools
module load megahit

# Make output dir
OUTDIR=/home/tobia/Genome_analysis/ga_analyses/02_assembly/test_megahit_out
mkdir -p $OUTDIR

# Run MEGAHIT with a subset of reads (e.g. first 100k lines = 25k reads)
megahit \
  -1 <(zcat /home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz | head -n 100000) \
  -2 <(zcat /home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_2.paired.trimmed.fastq.gz | head -n 100000) \
  -o $OUTDIR \
  --min-contig-len 500 \
  --presets meta-sensitive
