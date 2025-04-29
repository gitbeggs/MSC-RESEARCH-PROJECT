#Terminal loop for mapping reads to B.subtilis genome

# Loop through samples 1 to 53
for i in {1..53}; do
  echo "Processing Sample $i"

  # Define the directory where the input files are located
  SAMPLE_DIR="/Volumes/Francesco_P/barley_metatranscriptomics/Trimmed/Sample_${i}-RNA_CGR_${i}"

  # Define input files for each sample using the new directory path
  R1="${SAMPLE_DIR}/${i}-RNA_CGR_${i}_R1_TRIMMED_CLEANED_PAIRED.fastq.gz"
  R2="${SAMPLE_DIR}/${i}-RNA_CGR_${i}_R2_TRIMMED_CLEANED_PAIRED.fastq.gz"

  # Run BBMap with the defined input files
  /Volumes/Francesco_P/bbmap/bbmap.sh threads=8 32bit=t minid=0.9 nodisk=f nzo=f ambiguous=best strictmaxindel=4 \
  ref=/Volumes/Francesco_P/Bsubtilis_genome/252424E_Bacillussubtilis.fasta \
  in=$R1 \
  in2=$R2 \
  outm=RNAseq_data_merged_${i}-RNA_CGR_${i}_bsubtilis.sam \
  outu=null \
  statsfile=RNAseq_data_merged_${i}-RNA_CGR_${i}_summary_bsubtilis.txt \
  -Xmx100g

  # Run samtools commands to process the .sam file
  samtools faidx /Volumes/Francesco_P/Bsubtilis_genome/252424E_Bacillussubtilis.fasta

  # Sort the .sam file into .bam and place it in the BAM_files_b.subtilis folder
  samtools sort -o /Volumes/Francesco_P/barley_metatranscriptomics/Trimmed/BAM_files_b.subtilis/RNAseq_data_merged_${i}-RNA_CGR_${i}_bsubtilis.bam -@ 14 RNAseq_data_merged_${i}-RNA_CGR_${i}_bsubtilis.sam

  # Index the .bam file
  samtools index /Volumes/Francesco_P/barley_metatranscriptomics/Trimmed/BAM_files_b.subtilis/RNAseq_data_merged_${i}-RNA_CGR_${i}_bsubtilis.bam

  # Optional cleanup: remove the .sam file after the BAM file is created
  rm RNAseq_data_merged_${i}-RNA_CGR_${i}_bsubtilis.sam
