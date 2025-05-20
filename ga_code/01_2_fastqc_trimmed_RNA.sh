#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_trimmed_RNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/fastqc_trimmed_RNA-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/fastqc_trimmed_RNA-%j.err

# Load FastQC module
module load bioinfo-tools
module load FastQC

# Define input/output directories
INPUT_DIR=/home/tobia/Genome_analysis/ga_data/trimmed_data
OUTPUT_DIR=/home/tobia/Genome_analysis/ga_analyses/01_preprocessing/fastqc_trim

# Create output directory if it doesn't exist
mkdir -p $OUTPUT_DIR

# Run FastQC on all trimmed FASTQ files
fastqc -t 2 -o $OUTPUT_DIR $INPUT_DIR/*.fastq.gz
