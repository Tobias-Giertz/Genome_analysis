import pandas as pd
import os
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path

# Define the base directory where annotation files are located
base_dir = Path("/domus/h1/tobia/Genome_analysis/ga_analyses/07_eggnog")

# Prepare a dictionary to collect data
cog_counts = {}
kegg_counts = {}
go_counts = {}

# Process each .annotations file
for ann_file in base_dir.glob("bin_*_eggnog/*.annotations"):
    bin_name = ann_file.parent.name.replace("_eggnog", "")
    cog_counts[bin_name] = {}
    kegg_counts[bin_name] = {}
    go_counts[bin_name] = {}
    
    df = pd.read_csv(ann_file, sep='\t', comment='#', low_memory=False)
    
    # Count COG categories
    if 'COG cat' in df.columns:
        df_cog = df['COG cat'].dropna().str.split(',', expand=True).stack()
        cog_counts[bin_name] = df_cog.value_counts().to_dict()
        
    # Count KEGG pathways
    if 'KEGG_ko' in df.columns:
        df_kegg = df['KEGG_ko'].dropna().str.split(',', expand=True).stack()
        kegg_counts[bin_name] = df_kegg.value_counts().to_dict()

    # Count GO terms
    if 'GOs' in df.columns:
        df_go = df['GOs'].dropna().str.split(',', expand=True).stack()
        go_counts[bin_name] = df_go.value_counts().to_dict()

# Convert dictionaries to DataFrames
df_cog = pd.DataFrame.from_dict(cog_counts, orient='index').fillna(0).astype(int)
df_kegg = pd.DataFrame.from_dict(kegg_counts, orient='index').fillna(0).astype(int)
df_go = pd.DataFrame.from_dict(go_counts, orient='index').fillna(0).astype(int)

# Save to TSV files
summary_dir = base_dir / "summaries"
summary_dir.mkdir(exist_ok=True)

df_cog.to_csv(summary_dir / "cog_counts.tsv", sep='\t')
df_kegg.to_csv(summary_dir / "kegg_counts.tsv", sep='\t')
df_go.to_csv(summary_dir / "go_counts.tsv", sep='\t')

# Generate heatmaps
sns.heatmap(df_cog, cmap="Blues", linewidths=0.5)
plt.title("COG Category Counts")
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig(summary_dir / "cog_heatmap.png")
plt.clf()

sns.heatmap(df_kegg, cmap="Greens", linewidths=0.5)
plt.title("KEGG KO Counts")
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig(summary_dir / "kegg_heatmap.png")
plt.clf()

sns.heatmap(df_go, cmap="Oranges", linewidths=0.5)
plt.title("GO Term Counts")
plt.xticks(rotation=90)
plt.tight_layout()
plt.savefig(summary_dir / "go_heatmap.png")
plt.clf()

import ace_tools as tools; tools.display_dataframe_to_user(name="COG Category Counts", dataframe=df_cog)
