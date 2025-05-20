#!/bin/bash -l

#SBATCH -A uppmax2025-3-3
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J fastqc_compare
#SBATCH --mail-type=ALL
#SBATCH --mail-user=tobias.giertz.0318@student.uu.se
#SBATCH --output=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/fastqc_compare-%j.out
#SBATCH --error=/home/tobia/Genome_analysis/ga_code/ga_slurm_logs/fastqc_compare-%j.err

# Load FastQC
module load bioinfo-tools
module load FastQC

# Define paths
RAW=/home/tobia/Genome_analysis/ga_data/raw_data/RNA_untrimmed
TRIMMED=/home/tobia/Genome_analysis/ga_data/trimmed_data
OUTDIR=/home/tobia/Genome_analysis/ga_analyses/01_preprocessing/fastqc_compare
mkdir -p $OUTDIR

# Run FastQC on untrimmed and trimmed R1 of SRR4342137
fastqc -t 2 -o $OUTDIR \
  $RAW/SRR4342137.1.fastq.gz \
  $TRIMMED/SRR4342137_R1_paired.fastq.gz

# Optional: extract summary comparison
echo -e "Sample\tModule\tStatus" > $OUTDIR/fastqc_summary_comparison.tsv

for report in $OUTDIR/*_fastqc/summary.txt; do
    SAMPLE=$(basename $(dirname "$report") | sed 's/_fastqc//')
    awk -v s="$SAMPLE" '{print s "\t" $2 "\t" $1}' "$report" >> $OUTDIR/fastqc_summary_comparison.tsv
done

echo "Comparison summary written to: $OUTDIR/fastqc_summary_comparison.tsv"
