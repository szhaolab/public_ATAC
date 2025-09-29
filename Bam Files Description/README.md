### Sample folder naming convention

The ATAC_bam directory is organized into subfolders, each corresponding to one biological sample.  

These folders contain the outputs from **Step 2: MarkDuplicates** in the GATK/ATAC-seq processing workflow.  
For each sequencing run (SRR ID), the pipeline produces a duplicate-marked BAM file:

SRR7650729.dupmark.bam
SRR7650730.dupmark.bam
…
SRR7650770.dupmark.bam

- **Folder format:**
  
- `<SampleID>`: internal sample identifier (e.g. `1001`, `1002`).  
- `<RunRange>`: range of SRR runs included in that sample.  

- **Examples:**  
- `/ATAC_bam/1001(1-42)/`  
  - Sample ID = 1001  
  - Contains SRR runs **1–42** (SRR7650729–SRR7650770).  
  - Each run has a `.dupmark.bam` file produced by MarkDuplicates.  
  - `bam_paths.txt` lists the full paths of these BAM files.  
- `/ATAC_bam/1002(43-83)/`  
  - Sample ID = 1002  
  - Contains SRR runs **43–83**.

```markdown
/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1001(1-42)
├── bam_paths.txt
├── SRR7650729.dupmark.bam
├── SRR7650729.dupmark.bam.bai
├── SRR7650729.dup_metrics.txt
├── SRR7650730.dupmark.bam
├── SRR7650730.dupmark.bam.bai
├── SRR7650730.dup_metrics.txt
...
├── SRR7650770.dupmark.bam
├── SRR7650770.dupmark.bam.bai
└── SRR7650770.dup_metrics.txt

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1002(43-83)
├── bam_paths.txt
├── SRR7650771.dupmark.bam
├── SRR7650771.dupmark.bam.bai
├── SRR7650771.dup_metrics.txt
...
└── SRR7650811.dup_metrics.txt

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1003(84-122)
├── bam_paths.txt
├── SRR7650812.dupmark.bam
├── SRR7650812.dupmark.bam.bai
├── SRR7650812.dup_metrics.txt
...
└── SRR7650850.dup_metrics.txt

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1004(123-159)
├── bam_paths.txt
├── SRR7650851.dupmark.bam
├── SRR7650851.dupmark.bam.bai
├── SRR7650851.dup_metrics.txt
...
└── SRR7650887.dup_metrics.txt
