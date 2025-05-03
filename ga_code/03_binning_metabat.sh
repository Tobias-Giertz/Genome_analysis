#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=32G
#SBATCH -t 04:00:00
#SBATCH -J binning_metabat
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/binning_metabat-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/binning_metabat-%j.err

# Load required modules
module load bioinfo-tools
module load bwa
module load samtools
module load metabat

# Define paths
CONTIGS=/home/tobia/Genome_analysis/ga_analyses/02_assembly/full_megahit_out/final.contigs.fa
READ1=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz,/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_1.paired.trimmed.fastq.gz
READ2=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_2.paired.trimmed.fastq.gz,/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_2.paired.trimmed.fastq.gz
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
mkdir -p $OUTDIR

# Index the contigs
bwa index $CONTIGS

# Map reads to contigs and convert to BAM
bwa mem -t 4 $CONTIGS $READ1 $READ2 | samtools view -Sb - > $OUTDIR/mapped.bam

# Sort and index BAM
samtools sort -@ 4 -o $OUTDIR/mapped.sorted.bam $OUTDIR/mapped.bam
samtools index $OUTDIR/mapped.sorted.bam

# Estimate depth per contig
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/depth.txt $OUTDIR/mapped.sorted.bam

# Run MetaBAT2 to bin the contigs
metabat2 -i $CONTIGS -a $OUTDIR/depth.txt -o $OUTDIR/bin
