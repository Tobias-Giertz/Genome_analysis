#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH --mem=8G
#SBATCH -t 01:00:00
#SBATCH -J assembly_quast
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/quast-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/quast-%j.err

# Load QUAST
module load bioinfo-tools
module load quast

# Paths
CONTIGS=/home/tobia/Genome_analysis/ga_analyses/02_assembly/full_megahit_out/final.contigs.fa
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/04_1_quast
mkdir -p $OUTDIR

# Run QUAST
quast.py $CONTIGS -o $OUTDIR -t 2 --min-contig 1000
