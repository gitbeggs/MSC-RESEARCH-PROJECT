<img width="690" alt="Screenshot 2025-04-30 at 12 06 53" src="https://github.com/user-attachments/assets/df0c7c9a-dd31-44fb-b29c-1983573d2597" /># MSC-RESEARCH-PROJECT
Code repository for life 703 aphid project.

# Project Overview

This repository contains the bioinformatics pipeline used to process metatranscriptomic data from a plant-microbe interaction experiment in barley. The primary aim was to assess differences in bacterial gene expression across treatments using RNA sequencing (RNA-seq).

RNA-seq enables the quantification of gene expression by sequencing RNA transcripts. In this study, the approach was used to compare bacterial transcriptomes between inoculated and uninoculated barley plants, under varying biotic conditions (aphid presence/absence) and over time (Day 1, Day 7, Day 14). By mapping reads back to the bacterial genomes, we could quantify gene expression and identify differentially expressed genes (DEGs).

The main goal of this project is to identify differentially expressed genes (DEGs) associated with microbial inoculation compared to the control condition. We assess whether inoculation with A. radicis or B. subtilis leads to transcriptional changes in the rhizosphere, and how these effects differ in the presence or absence of aphids. DEGs were analysed at each time point to observe temporal dynamics in the root microbiome, with the broader aim of understanding whether these microbial interactions contribute to aphid suppression—a potential mechanism of natural pest control in crops.

<img width="1009" alt="Screenshot 2025-04-30 at 12 08 28" src="https://github.com/user-attachments/assets/4607399c-9fa9-4e35-93aa-fdfc3748e5f3" />

# Experimental Design

Samples: 53 rhizosphere samples (barley root tips)


# Treatments:
Conditions: Each treatment replicated with and without aphids

Time Points: Day 1, Day 7, Day 14 (no samples for Day 7 without aphids)

# Acidovorax radicis
Day 1 with aphids: Samples 1–4

Day 7 with aphids: Samples 13–16

Day 14 with aphids: Samples 22–25

Day 1 without aphids: Samples 34–37

Day 14 without aphids: Samples 44–46

# Bacillus subtilis
Day 1 with aphids: Samples 5–8

Day 7 with aphids: Samples 17–19

Day 14 with aphids: Samples 26–29

Day 1 without aphids: Samples 38–41

Day 14 without aphids: Samples 47–49

# No Bacteria (Control)
Day 1 with aphids: Samples 9–12

Day 7 with aphids: Samples 20–21

Day 14 with aphids: Samples 30–33

Day 1 without aphids: Samples 42–43

Day 14 without aphids: Samples 50–53

<img width="697" alt="Screenshot 2025-04-30 at 12 07 12" src="https://github.com/user-attachments/assets/42720d1c-4f3a-4b6e-b04d-e45d2d1d495c" />


# Processing Pipeline Summary

Raw Illumina paired-end reads were processed through a multi-step workflow to produce genome-aligned BAM files for quantifying bacterial gene expression. Mapping the reads of each samples rhizosphere to Acidovorax radicis genome then to Bacillius Subtillis, to quantify the gene expression of each bacteria across the 53 samples.

# Terminal processing of raw reads (shell scripts attached in repoistory)

i) Terminal pipeline for transcript mapping to A. Radicis: RAW READS TO BAM FILES BASH CODE (acidovorax radicis).sh

ii) Terminal pipeline for transcript mapping to B.subtilis genome: RNA SEQ WORKFLOW MAPPING TO BACILLUS SUBTILIS GENOME.sh

# Breakdown of raw reads processing pipeline

# 1. Adapter Trimming
Tool: bbduk.sh

Adapter sequences were trimmed from raw reads to improve mapping accuracy.

# 2. Read Concatenation
Each sample had two R1 and two R2 FASTQ files, which were concatenated (R1s together, R2s together) to streamline processing.

# 3. rRNA Removal
Tool: bbduk.sh with SILVA rRNA database

Reads matching ribosomal RNA sequences were removed to enrich for messenger RNA (mRNA).

# 4. Re-pairing of Reads
Tool: repair.sh

Following rRNA filtering, paired-end reads were re-synchronized to ensure valid pairs.

# 5. Genome Mapping
Tool: bbmap.sh

Filtered reads were aligned to the Acidovorax radicis and Bacillus subtilis reference genomes, depending on the treatment condition.
Purpose: Quantify gene expression in bacteria inoculated into the rhizosphere, with or without aphid presence, compared to uninoculated controls.

# 6. SAM to BAM Conversion
Tool: samtools

SAM alignment files were converted to sorted and indexed BAM files for efficient storage and analysis.

# 7. Coverage Estimation
Tool: samtools

Read coverage across bacterial genes was calculated for each of the 53 samples to assess genome coverage.






