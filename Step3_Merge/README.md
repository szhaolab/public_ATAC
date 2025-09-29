### Step 3: Merge per-run BAMs (SLURM job)

The script `merge.sh` merges all per-run duplicate-marked BAMs (`*.dupmark.bam`) into one BAM per sample.  
- **Input**: per-run `.dupmark.bam` files from folders like `1001(1-42)/`, `1002(43-83)/`, etc.  
- **Output**: each merged BAM and its index are stored in the corresponding `Individual` folder:

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/1001.merged.bam
/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/1001.merged.bam.bai

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual2/1002.merged.bam
/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual2/1002.merged.bam.bai

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual3/1003.merged.bam
/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual3/1003.merged.bam.bai

/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual4/1004.merged.bam
/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual4/1004.merged.bam.bai
