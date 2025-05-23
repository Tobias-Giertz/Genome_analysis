library(tidyverse)
library(pheatmap)

setwd("/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog/summaries")

plot_top_heatmap <- function(file, id_col, value_col, label, outfile, top_n = 20) {
  df <- read_tsv(file)
  
  # Filter out unknown category (e.g., "-")
  df <- df %>% filter({{id_col}} != "-")
  
  # Select top N categories by total count
  df_top <- filter_top_n(df, {{id_col}}, {{value_col}}, top_n)
  
  # Prepare matrix for heatmap
  mat <- df_top %>%
    pivot_wider(names_from = {{id_col}}, values_from = {{value_col}}, values_fill = 0) %>%
    column_to_rownames("Bin") %>%
    as.matrix()
  
  # Generate heatmap
  pheatmap(mat, fontsize_row = 8, fontsize_col = 8,
           main = paste(label, "- Top", top_n),
           filename = outfile)
}

plot_top_heatmap("cog_counts.tsv", COG_Category, Count, "COG", "cog_top20_heatmap.png", 20)
plot_top_heatmap("kegg_counts.tsv", KEGG_KO, Count, "KEGG", "kegg_top20_heatmap.png", 20)
plot_top_heatmap("go_counts.tsv", GO_Term, Count, "GO Terms", "go_top20_heatmap.png", 20)
