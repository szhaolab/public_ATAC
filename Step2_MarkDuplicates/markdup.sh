#!/bin/bash -l
#SBATCH --job-name=markdup
#SBATCH --output=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/result/markdup_%A_%a.out
#SBATCH --time=24:00:00
#SBATCH --account=nccc
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --array=0-41
#SBATCH --mail-user=f0070pp@dartmouth.edu
#SBATCH --mail-type=BEGIN,END,FAIL

echo "Job $SLURM_JOB_ID starting at $(date) on $(hostname)"

source /optnfs/common/miniconda3/etc/profile.d/conda.sh
conda activate atac_java17

LIST="/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1001(1-42)/bam_paths.txt"
OUTDIR="/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/1001(1-42)"
TMPDIR="/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/tmp_user/picard_tmp"   

mkdir -p "$OUTDIR" "$TMPDIR"

BAM=$(sed -n "$((SLURM_ARRAY_TASK_ID + 1))p" "$LIST")
base=$(basename "$BAM" .fastq.srt.bam)  
SRR=${base%%_*}                         

echo "[$(date)] Start  $SRR  (array idx $SLURM_ARRAY_TASK_ID)"

picard \
    -Xmx16g \
    -XX:ParallelGCThreads=1 \
    MarkDuplicates \
    INPUT="$BAM" \
    OUTPUT="$OUTDIR/${SRR}.dupmark.bam" \
    METRICS_FILE="$OUTDIR/${SRR}.dup_metrics.txt" \
    VALIDATION_STRINGENCY=LENIENT \
    USE_JDK_DEFLATER=TRUE \
    USE_JDK_INFLATER=TRUE \
    ASSUME_SORTED=TRUE \
    REMOVE_DUPLICATES=FALSE \
    TMP_DIR="$TMPDIR"

samtools index -@4 "$OUTDIR/${SRR}.dupmark.bam"

echo "Job $SLURM_JOB_ID finished $SRR at $(date)"