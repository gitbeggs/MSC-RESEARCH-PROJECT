#RNA SEQ WORKFLOW MAPPING TO BACILLUS SUBTILIS GENOME

echo "The first step is to concatenate the R1 files and the R2 files together"

echo "concatenate R1:R1 files"
cat 48-RNA_CGR_48_GACTCATCCA-GAACCAAGCG_L003_R1_001.fastq.gz 48-RNA_CGR_48_GACTCATCCA-GAACCAAGCG_L004_R1_001.fastq.gz > RNAseq_data_merged_48-RNA_CGR_48_R1_TRIMMED.fastq.gz

echo "concatenate R2:R2 files" 
cat 48-RNA_CGR_48_GACTCATCCA-GAACCAAGCG_L003_R2_001.fastq.gz 48-RNA_CGR_48_GACTCATCCA-GAACCAAGCG_L004_R2_001.fastq.gz > RNAseq_data_merged_48-RNA_CGR_48_R2_TRIMMED.fastq.gz

echo "The second step is to filter out the reads mapping rRNA sequences contained in the SILVA database."
echo "We manually added the sequences of the 16s, 23s and 5s of our 4 strains to the SILVA database."

/Volumes/Francesco_P/bbmap/bbduk.sh in=RNAseq_data_merged_48-RNA_CGR_48_R1_TRIMMED.fastq.gz in2=RNAseq_data_merged_48-RNA_CGR_48_R2_TRIMMED.fastq.gz \
ref=/Volumes/Francesco_P/barley_metatranscriptomics/Trimmed/Sample_25-RNA_CGR_25/Sample_25-RNA_CGR_25_COUNTS/SILVA_138.1_SSURef_NR99_tax_silva.fasta.gz out1=RNAseq_data_merged_48-RNA_CGR_48_R1_TRIMMED_CLEANED.fastq.gz \
out2=RNAseq_data_merged_48-RNA_CGR_48_R2_TRIMMED_CLEANED.fastq.gz k=25 stats=RNAseq_data_merged_48-RNA_CGR_48_SUMMARY_STATS.txt -Xmx24g

echo "The third step consists in the re-pairing of the reads"

/Volumes/Francesco_P/bbmap/repair.sh overwrite=t in=RNAseq_data_merged_48-RNA_CGR_48_R1_TRIMMED_CLEANED.fastq.gz \
in2=RNAseq_data_merged_48-RNA_CGR_48_R2_TRIMMED_CLEANED.fastq.gz out=3-RNA_CGR_48_R1_TRIMMED_CLEANED_PAIRED.fastq.gz \
out2=3-RNA_CGR_48_R2_TRIMMED_CLEANED_PAIRED.fastq.gz

echo "The fourth step consists in the mapping of the reads to the genome reference"
echo "Mapping to the 4 concatenated genomes ..."

/Volumes/Francesco_P/bbmap/bbmap.sh threads=8 32bit=t minid=0.9 nodisk=f nzo=f ambiguous=best strictmaxindel=4 ref=/Volumes/Francesco_P/Bsubtilis_genome/252424E_Bacillussubtilis.fasta \
in=8-RNA_CGR_8_R1_TRIMMED_CLEANED_PAIRED.fastq.gz in2=8-RNA_CGR_8_R2_TRIMMED_CLEANED_PAIRED.fastq.gz \
outm=RNAseq_data_merged_8-RNA_CGR_8_bsubtilis.sam outu=null statsfile=RNAseq_data_merged_8-RNA_CGR_8_summary_bsubtilis.txt -Xmx100g

samtools faidx /Volumes/Francesco_P/Bsubtilis_genome/252424E_Bacillussubtilis.fasta
samtools sort -o RNAseq_data_merged_8-RNA_CGR_8_bsubtilis.bam  -@ 14 RNAseq_data_merged_8-RNA_CGR_8_bsubtilis.sam
samtools index RNAseq_data_merged_8-RNA_CGR_8_bsubtilis.bam









