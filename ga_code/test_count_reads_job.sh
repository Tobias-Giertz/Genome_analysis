#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH --reservation=uppmax2025-3-3_2
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:02:00
#SBATCH -J test_count_reads
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/test_count_reads-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/test_count_reads-%j.err

# Load module
module load bioinfo-tools

# Run your count script
/home/tobia/Genome_analysis/ga_code/count_reads.sh /home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz
