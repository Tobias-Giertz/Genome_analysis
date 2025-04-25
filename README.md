#1MB462 #projekt 

## Genome Analysis Project — Paper III (Thrash et al. 2017)

### Project Overview

This repository contains all files and documentation for a genome analysis project based on:

> **Paper III: Metabolic roles of uncultivated bacterioplankton lineages in the Northern Gulf of Mexico “dead zone”**  
> J. Cameron Thrash et al., 2017

The aim of this project is to reproduce and expand on the metagenomic analyses presented in the paper using a subset of the same Illumina data used in the study and bioinformatics tools on the UPPMAX cluster.

---

### Repository Structure

``` bash
Genome_analysis/
├── ga_analyses/          # All downstream analysis outputs
│   ├── 01_preprocessing/
│   ├── 02_assembly/
│   ├── 03_binning/
│   └── ...
├── ga_code/              # All scripts and SLURM job files
├── ga_data/              # Links to raw data, trimmed reads, metadata
│   ├── raw_data/
│   ├── trimmed_data/
│   └── metadata/
├── ga_slurm_logs/        # SLURM output and error logs
├── log.md                # Day-by-day project progress log
└── README.md             # Project overview (this file)
```



---

### Analyses Performed

- [x] Preprocessing of RNA and DNA reads with Trimmomatic
- [x] Test and full assembly of metagenomic reads using MEGAHIT
- [ ] Binning with MetaBAT2
- [ ] Bin quality assessment with CheckM
- [ ] Annotation of bins with Prokka / eggNOGmapper
- [ ] RNA mapping and expression analysis

---

### Tools and Technologies

- UPPMAX (Snowy cluster)
- GitHub (version control)
- Bash & SLURM scripting
- Trimmomatic, MEGAHIT, BWA, Samtools, MetaBAT2, and more

---

### Project Goals

- Reproduce core analyses from the original paper
- Gain experience using large-scale bioinformatics tools and UPPMAX
- Explore metagenomic binning and annotation
- Practice good data organization and version control
