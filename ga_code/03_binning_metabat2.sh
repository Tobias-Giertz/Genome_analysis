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

# Load modules
module load bioinfo-tools
module load bwa
module load samtools
module load MetaBat/2.12.1

# Paths
CONTIGS=/home/tobia/Genome_analysis/ga_analyses/02_assembly/full_megahit_out/final.contigs.fa
READ1_1=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_1.paired.trimmed.fastq.gz
READ1_2=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342129_2.paired.trimmed.fastq.gz
READ2_1=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_1.paired.trimmed.fastq.gz
READ2_2=/home/tobia/Genome_analysis/ga_data/raw_data/DNA_trimmed/SRR4342133_2.paired.trimmed.fastq.gz
OUTDIR=/proj/uppmax2025-3-3/nobackup/tobia/03_binning
mkdir -p $OUTDIR

# Index contigs
bwa index $CONTIGS

# Map both read pairs separately and merge BAMs
bwa mem -t 4 $CONTIGS $READ1_1 $READ1_2 | samtools view -Sb - > $OUTDIR/tmp1.bam
bwa mem -t 4 $CONTIGS $READ2_1 $READ2_2 | samtools view -Sb - > $OUTDIR/tmp2.bam

rm -f $OUTDIR/mapped.bam
samtools merge -@ 4 $OUTDIR/mapped.bam $OUTDIR/tmp1.bam $OUTDIR/tmp2.bam
rm $OUTDIR/tmp1.bam $OUTDIR/tmp2.bam

# Sort and index BAM
samtools sort -@ 4 -o $OUTDIR/mapped.sorted.bam $OUTDIR/mapped.bam
samtools index $OUTDIR/mapped.sorted.bam


# Estimate depth
jgi_summarize_bam_contig_depths --outputDepth $OUTDIR/depth.txt $OUTDIR/mapped.sorted.bam

# Run MetaBAT2
metabat2 -i $CONTIGS -a $OUTDIR/depth.txt -o $OUTDIR/bin
