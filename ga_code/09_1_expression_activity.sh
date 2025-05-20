#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH --mem=16G
#SBATCH -t 04:00:00
#SBATCH -J expression_activity
#SBATCH --output=ga_code/ga_slurm_logs/expression_activity-%j.out
#SBATCH --error=ga_code/ga_slurm_logs/expression_activity-%j.err

module load bioinfo-tools
module load bowtie2
module load samtools
module load subread

REF=/home/tobia/Genome_analysis/ga_analyses/02_assembly/full_megahit_out/final.contigs.fa
INDEX_DIR=/home/tobia/Genome_analysis/ga_data/reference/index
TRIMMED=/home/tobia/Genome_analysis/ga_data/trimmed_data
ALIGNMENTS=/home/tobia/Genome_analysis/ga_analyses/02_alignment
GTF=/home/tobia/Genome_analysis/ga_data/reference/annotations.gtf
OUTDIR=/home/tobia/Genome_analysis/ga_analyses/03_counts

mkdir -p $INDEX_DIR $ALIGNMENTS $OUTDIR

# Index reference
bowtie2-build $REF $INDEX_DIR/genome_index

# Align
bowtie2 -x $INDEX_DIR/genome_index \
  -1 $TRIMMED/SRR4342137_R1_paired.fastq.gz \
  -2 $TRIMMED/SRR4342137_R2_paired.fastq.gz \
  -S $ALIGNMENTS/SRR4342137.sam \
  -p 2

# Convert and sort
samtools view -Sb $ALIGNMENTS/SRR4342137.sam | samtools sort -o $ALIGNMENTS/SRR4342137_sorted.bam
samtools index $ALIGNMENTS/SRR4342137_sorted.bam

# Count reads
featureCounts -T 2 -p -B -C \
  -a $GTF \
  -o $OUTDIR/gene_counts.txt \
  $ALIGNMENTS/SRR4342137_sorted.bam
