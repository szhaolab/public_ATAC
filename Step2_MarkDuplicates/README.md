The script `markdup.sh` runs Picard **MarkDuplicates** on each BAM listed in `bam_paths.txt` using a SLURM job array.  
- **Input**: sorted BAMs from `bam_paths.txt`  
- **Process**:  
  1. Mark duplicates → `<SRR>.dupmark.bam` + `<SRR>.dup_metrics.txt`  
  2. Index BAM → `<SRR>.dupmark.bam.bai`  
- **Output**: duplicate-marked BAM files, used as input for GATK BaseRecalibrator.

`dupmark` refers to **duplicate-marked BAM files** produced by Picard **MarkDuplicates**.  
- PCR or optical duplicates are identified in the alignment.  
- Reads are *not removed*, but marked in the BAM file.  
- Along with the BAM, Picard also generates a metrics file (`<SRR>.dup_metrics.txt`) that summarizes duplication rates.  
- These `.dupmark.bam` files are used for downstream analysis (e.g., base quality recalibration in GATK).  
