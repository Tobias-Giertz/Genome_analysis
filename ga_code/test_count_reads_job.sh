#!/bin/bash -l

#SBATCH -A uppmax2025-3-3_2
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:02:00
#SBATCH -J test_count_reads
#SBATCH --mail-type=ALL 
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=ga_code/ga_slurm_logs/test_count_reads-%j.out

# Load modules
module load bioinfo-tools

# Run your script on one of the raw files
./ga_code/count_reads.sh ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz
