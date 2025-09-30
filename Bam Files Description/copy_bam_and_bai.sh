#!/bin/bash
# copy_bam_and_bai.sh
# Copy BAM and BAI files listed in bam_paths.txt and bai_paths.txt into DEST

DEST="/dartfs/rc/lab/S/Szhao/public-ATAC/1001(1-42)"

# Copy BAM files
xargs -a "$DEST/bam_paths.txt" -I{} cp {} "$DEST/"

# Copy BAI files
xargs -a "$DEST/bai_paths.txt" -I{} cp {} "$DEST/"

echo "BAM and BAI files copied to $DEST"
