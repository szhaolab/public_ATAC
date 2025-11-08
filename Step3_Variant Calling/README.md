### Step 3: GATK Variant Calling Pipeline

This SLURM script performs **GATK HaplotypeCaller–based variant calling** on each merged BAM file.
The workflow adds read group information (required by GATK) and then runs variant calling directly to produce a raw VCF file.

**Input:**

* Merged BAM file: `1001.merged.bam`
* Reference genome: `GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta`

**Output:**

* BAM with read groups: `1001.merged.withRG.bam`
* Raw variant calls: `1001.hc.raw.vcf`

---

#### **Pipeline steps**

1. **AddOrReplaceReadGroups (Picard)**

   * Adds read group (`RG`) tags required by GATK for downstream processing.
   * If the `.withRG.bam` already exists, the script skips this step.
   * **Input:** `1001.merged.bam`
   * **Output:** `1001.merged.withRG.bam` + `1001.merged.withRG.bam.bai`

2. **Indexing (samtools index)**

   * Ensures an index (`.bai`) is present for the BAM file with RG.
   * Skipped automatically if the index already exists.

3. **Variant Calling (GATK HaplotypeCaller)**

   * Performs SNP and indel discovery directly on the BAM with RG.
   * Uses parameters: `--min-pruning 10` and `--standard-min-confidence-threshold-for-calling 20.0`.
   * **Input:** `1001.merged.withRG.bam`
   * **Output:** `1001.hc.raw.vcf`

---

#### **Notes**

* The current script does not include **BQSR**, or **variant filtration** steps.



