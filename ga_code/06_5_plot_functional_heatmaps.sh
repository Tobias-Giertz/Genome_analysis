#!/bin/bash

module load bioinfo-tools
module load R

Rscript << 'EOF'
# Load packages
library(tidyverse)
library(reshape2)
library(pheatmap)

# Set working dir
setwd("/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog/summaries")

# Function to plot
plot_heatmap <- function(file, id_col, value_col, label, outfile) {
  df <- read_tsv(file)
  mat <- df %>%
    pivot_wider(names_from = {{id_col}}, values_from = {{value_col}}, values_fill = 0) %>%
    column_to_rownames("Bin") %>%
    as.matrix()
  
  pheatmap(mat, fontsize_row=8, fontsize_col=8, 
           main=paste(label, "Annotations"), 
           filename=outfile)
}

# Plot heatmaps
plot_heatmap("cog_counts.tsv", COG_Category, Count, "COG", "cog_heatmap.png")
plot_heatmap("kegg_counts.tsv", KEGG_KO, Count, "KEGG", "kegg_heatmap.png")
plot_heatmap("go_counts.tsv", GO_Term, Count, "GO Terms", "go_heatmap.png")
EOF
