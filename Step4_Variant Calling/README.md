### Step 4: GATK variant calling pipeline

This SLURM script runs the full GATK best-practices workflow on a merged BAM file:  

1. **MarkDuplicates (Picard)**  
   - Input: `1001.merged.bam`  
   - Output: `1001.merged.dupmark.bam` + `1001.dup_metrics.txt`  

2. **Base quality score recalibration (BQSR)**  
   - `BaseRecalibrator` builds recalibration table using known sites (dbSNP, Mills indels).  
   - `ApplyBQSR` produces `1001.recal.bam`.  

3. **Variant calling (HaplotypeCaller)**  
   - Generates GVCF: `1001.g.vcf.gz`.  

4. **Joint genotyping (GenotypeGVCFs)**  
   - Converts GVCF into raw VCF: `1001.raw.vcf.gz`.  

5. **Variant filtration (VariantFiltration)**  
   - Applies standard hard filters (QD, FS, MQ, SOR, MQRankSum, ReadPosRankSum).  
   - Final output: `1001.filtered.vcf.gz`.  
