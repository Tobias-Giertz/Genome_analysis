#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH --reservation=uppmax2025-3-3_3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 06:00:00
#SBATCH -J full_megahit
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/resume_megahit-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/resume_megahit-%j.err

# Load modules
module load bioinfo-tools
module load megahit


# Run MEGAHIT with a subset of reads (e.g. first 100k lines = 25k reads)
megahit \
  -1 /home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz,/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_1.paired.trimmed.fastq.gz \
  -2 /home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_2.paired.trimmed.fastq.gz,/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_2.paired.trimmed.fastq.gz \
  -o /home/tobia/Genome_analysis/ga_analyses/02_assembly/full_megahit_out \
  --min-contig-len 1000 \
  --presets meta-sensitive
