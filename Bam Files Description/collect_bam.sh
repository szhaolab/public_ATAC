#!/bin/bash
# collect_bam_paths.sh
# Script to collect BAM and BAI file paths for documentation

# Root directory containing pipeline outputs
OUTROOT='/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data'

# Destination directory to save lists
DEST='/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Graham/1001(1-42)'

# Create destination if it does not exist
mkdir -p "$DEST"

# Collect BAM file paths
find $OUTROOT/output/{1-10,11-20,21-30,31-40,41-50} \
     -path '*/glob-*' -prune -o \
     -path '*/call-filter/*' -name '*_1.fastq.srt.nodup.no_chrM_MT.bam' -print \
  | sort -V | sed -n '1,42p' \
  > "$DEST/bam_paths.txt"

# Collect BAI file paths
find $OUTROOT/output/{1-10,11-20,21-30,31-40,41-50} \
     -path '*/call-align_mito/*' -prune -o \
     -path '*/call-align/*' -prune -o \
     -path '*/call-tss_enrich/*' -prune -o \
     -path '*glob-*' -prune -o \
     -name '*_1.fastq.srt.nodup.no_chrM_MT.bam.bai' -print \
  | sort -V | sed -n '1,42p' \
  > "$DEST/bai_paths.txt"

echo "BAM and BAI paths saved to $DEST"
