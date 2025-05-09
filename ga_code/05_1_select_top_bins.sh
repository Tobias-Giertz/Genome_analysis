#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -J select_top_bins
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/select_top_bins-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/select_top_bins-%j.err

# Define paths
INPUT_TSV=/home/tobia/Genome_analysis/ga_analyses/04_quality_control/checkm_bin_summary.tsv
OUTPUT_TSV=/home/tobia/Genome_analysis/ga_analyses/04_quality_control/top_bins.tsv

# Extract header and filter bins with completeness ≥ 70 and contamination ≤ 10
awk -F '\t' 'NR==1 || ($6+0) >= 70 && ($7+0) <= 10' "$INPUT_TSV" > "$OUTPUT_TSV"
