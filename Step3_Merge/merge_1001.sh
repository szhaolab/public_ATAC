#!/bin/bash -l
#SBATCH --job-name=merge
#SBATCH --output=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/result/merge_%A_%a.out
#SBATCH --time=24:00:00
#SBATCH --account=nccc
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mem=64G
#SBATCH --mail-user=f0070pp@dartmouth.edu
#SBATCH --mail-type=BEGIN,END,FAIL

echo "Job $SLURM_JOB_ID starting at $(date) on $(hostname)"

source /optnfs/common/miniconda3/etc/profile.d/conda.sh
conda activate atac

IN_DIR="/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1001(1-42)"
OUT_DIR="/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1"
mkdir -p "$OUT_DIR"

MERGED_BAM="$OUT_DIR/1001.merged.bam"

echo "[$(date)]  merging dupmark BAMs → $MERGED_BAM"
samtools merge -@${SLURM_CPUS_PER_TASK:-12} -f "$MERGED_BAM" \
               "$IN_DIR"/*.dupmark.bam

echo "[$(date)]  indexing"
samtools index -@${SLURM_CPUS_PER_TASK:-12} "$MERGED_BAM"

echo "Job $SLURM_JOB_ID finished $SRR at $(date)"