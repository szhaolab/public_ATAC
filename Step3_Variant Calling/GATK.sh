#!/bin/bash -l
#SBATCH --job-name=calling
#SBATCH --output=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/result/call_%A_%a.out
#SBATCH --time=24:00:00
#SBATCH --account=nccc
#SBATCH --partition=standard
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --mail-user=f0070pp@dartmouth.edu
#SBATCH --mail-type=BEGIN,END,FAIL

echo "Job $SLURM_JOB_ID starting at $(date) on $(hostname)"

source /optnfs/common/miniconda3/etc/profile.d/conda.sh
conda activate /dartfs/rc/lab/S/Szhao/qiruiz/env/gatk

SAMPLE_ID=1001
WORK=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1

GENOME_DIR=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/genome
REF=${GENOME_DIR}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta

BAM_MERGED=${WORK}/${SAMPLE_ID}.merged.bam
BAM_WITH_RG=${WORK}/${SAMPLE_ID}.merged.withRG.bam

OUTDIR=${WORK}/call_${SAMPLE_ID}
mkdir -p "${OUTDIR}"


VCF_OUT=${OUTDIR}/${SAMPLE_ID}.hc.raw.vcf
echo "SAMPLE_ID   = ${SAMPLE_ID}"
echo "MERGED_BAM  = ${BAM_MERGED}"
echo "REF         = ${REF}"
echo "OUTDIR      = ${OUTDIR}"

if [ ! -f "${BAM_WITH_RG}" ]; then
    echo "[`date`] BAM with RG not found, running AddOrReplaceReadGroups..."
    picard AddOrReplaceReadGroups \
        I="${BAM_MERGED}" \
        O="${BAM_WITH_RG}" \
        RGID="${SAMPLE_ID}" \
        RGLB="lib${SAMPLE_ID}" \
        RGPL="ILLUMINA" \
        RGPU="unit1" \
        RGSM="${SAMPLE_ID}" \
        VALIDATION_STRINGENCY=LENIENT
else
    echo "[`date`] BAM with RG already exists: ${BAM_WITH_RG}"
fi

if [ ! -f "${BAM_WITH_RG}.bai" ]; then
    echo "[`date`] BAM index for withRG not found, creating..."
    samtools index -@8 "${BAM_WITH_RG}"
else
    echo "[`date`] BAM index exists: ${BAM_WITH_RG}.bai"
fi


echo "Running HaplotypeCaller..."
gatk --java-options "-Xmx32g" HaplotypeCaller \
     -R "${REF}" \
     -I "${BAM_WITH_RG}" \
     -O "${VCF_OUT}" \
     --min-pruning 10 \
     --standard-min-confidence-threshold-for-calling 20.0

echo "[`date`] Done. Variant calling finished."
echo "         Output VCF: ${VCF_OUT}"

echo "Job $SLURM_JOB_ID finished at $(date)"