#!/bin/bash -l

#SBATCH -A uppmax2025-3-3     # Your project ID
#SBATCH -M snowy
#SBATCH -p core               # Partition (core/short etc.)
#SBATCH -n 2                  # Number of cores
#SBATCH -t 01:00:00           # Time limit (hh:mm:ss)
#SBATCH -J my_job_name        # Job name
#SBATCH -o slurm-%j.out       # STDOUT (%j = job ID)
#SBATCH -e slurm-%j.err       # STDERR

# Load required modules
module load bioinfo-tools
module load samtools

# Activate Conda environment if needed
# source activate my_env

# Your command goes here
echo "Running my script..."
./ga_code/count_reads.sh ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz
