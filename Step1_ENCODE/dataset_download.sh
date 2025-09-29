#!/bin/bash -l
#SBATCH --job-name=ATAC_dl
#SBATCH --output=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/result/download_%a.out
#SBATCH --time=24:00:00
#SBATCH --account=nccc
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64G
#SBATCH --array=101-159
#SBATCH --mail-user=f0070pp@dartmouth.edu
#SBATCH --mail-type=BEGIN,END,FAIL

echo "Job $SLURM_JOB_ID starting at $(date) on $(hostname)"

source /optnfs/common/miniconda3/etc/profile.d/conda.sh
conda activate ega

export NCBI_SETTINGS=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/ncbi
export NCBI_CACHE_ROOT=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/sra_tmp
mkdir -p $NCBI_SETTINGS $NCBI_CACHE_ROOT

LIST=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/SRR_Acc_List.txt
OUTDIR=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/fastq
mkdir -p $OUTDIR /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/result

SRR=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $LIST)
echo "Processing $SRR"

prefetch $SRR --output-directory $OUTDIR

fasterq-dump $OUTDIR/$SRR/$SRR.sra --split-files -e 8 -O $OUTDIR -t $NCBI_CACHE_ROOT

if [[ -s $OUTDIR/${SRR}_1.fastq || -s $OUTDIR/${SRR}.fastq ]]; then
    echo "FASTQ generated successfully for $SRR"

    rm -rf "$OUTDIR/$SRR"
    echo "Removed SRA cache for $SRR"
else
    echo "FASTQ generation failed for $SRR"
fi

echo "Job $SLURM_JOB_ID finished $SRR at $(date)"