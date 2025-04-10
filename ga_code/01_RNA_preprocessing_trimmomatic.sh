#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH --reservation=uppmax2025-3-3_3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J trim_RNA
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/trim_RNA-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/trim_RNA-%j.err

# Load Trimmomatic
module load bioinfo-tools
module load trimmomatic

# Define paths
RAW=/home/tobia/Genome_analysis/ga_data/raw_data/RNA_untrimmed
TRIMMED=/home/tobia/Genome_analysis/ga_data/trimmed_data
mkdir -p $TRIMMED

# Run Trimmomatic for each RNA sample
trimmomatic PE -threads 2 -phred33 \
  $RAW/SRR4342137.1.fastq.gz $RAW/SRR4342137.2.fastq.gz \
  $TRIMMED/SRR4342137_R1_paired.fastq.gz $TRIMMED/SRR4342137_R1_unpaired.fastq.gz \
  $TRIMMED/SRR4342137_R2_paired.fastq.gz $TRIMMED/SRR4342137_R2_unpaired.fastq.gz \
  ILLUMINACLIP:/sw/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

trimmomatic PE -threads 2 -phred33 \
  $RAW/SRR4342139.1.fastq.gz $RAW/SRR4342139.2.fastq.gz \
  $TRIMMED/SRR4342139_R1_paired.fastq.gz $TRIMMED/SRR4342139_R1_unpaired.fastq.gz \
  $TRIMMED/SRR4342139_R2_paired.fastq.gz $TRIMMED/SRR4342139_R2_unpaired.fastq.gz \
  ILLUMINACLIP:/sw/bioinfo/trimmomatic/0.39/rackham/adapters/TruSeq3-PE.fa:2:30:10 \
  LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

