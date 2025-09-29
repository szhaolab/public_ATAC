#!/bin/bash -l
#SBATCH --job-name=GATK
#SBATCH --output=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/result/GATK_%A_%a.out
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
conda activate atac

GENOME_DIR=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/genome
REF=${GENOME_DIR}/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta
DBSNP=${GENOME_DIR}/dbsnp_146.hg38.vcf.gz
MILLS=${GENOME_DIR}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz

SAMPLE_ID=1001
WORK=/dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1

BAM_MERGED=${WORK}/${SAMPLE_ID}.merged.bam
BAM_DD=${WORK}/${SAMPLE_ID}.merged.dupmark.bam
METRICS=${WORK}/${SAMPLE_ID}.dup_metrics.txt
BAM_REC=${WORK}/${SAMPLE_ID}.recal.bam
RECAL_TABLE=${WORK}/${SAMPLE_ID}.recal.table
GVCF=${WORK}/${SAMPLE_ID}.g.vcf.gz
VCF_RAW=${WORK}/${SAMPLE_ID}.raw.vcf.gz
VCF_FILT=${WORK}/${SAMPLE_ID}.filtered.vcf.gz
TMP_PICARD=${WORK}/tmp_picard
mkdir -p "${TMP_PICARD}"


picard \
    -Xmx64g \
    -XX:ParallelGCThreads=1 \
    MarkDuplicates \
    INPUT="${BAM_MERGED}" \
    OUTPUT="${BAM_DD}" \
    METRICS_FILE="${METRICS}" \
    VALIDATION_STRINGENCY=LENIENT \
    USE_JDK_DEFLATER=TRUE \
    USE_JDK_INFLATER=TRUE \
    ASSUME_SORTED=TRUE \
    REMOVE_DUPLICATES=FALSE \
    TMP_DIR="${TMP_PICARD}"

samtools index -@8 "${BAM_DD}"


gatk --java-options "-Xmx32g" BaseRecalibrator \
     -R "${REF}" \
     -I "${BAM_DD}" \
     --known-sites "${DBSNP}" \
     --known-sites "${MILLS}" \
     -O "${RECAL_TABLE}"

gatk --java-options "-Xmx32g" ApplyBQSR \
     -R "${REF}" \
     -I "${BAM_DD}" \
     --bqsr-recal-file "${RECAL_TABLE}" \
     -O "${BAM_REC}"

samtools index -@8 "${BAM_REC}"


gatk --java-options "-Xmx48g" HaplotypeCaller \
     -R "${REF}" \
     -I "${BAM_REC}" \
     -O "${GVCF}" \
     -ERC GVCF \
     --native-pair-hmm-threads 16


gatk --java-options "-Xmx32g" GenotypeGVCFs \
     -R "${REF}" \
     -V "${GVCF}" \
     -O "${VCF_RAW}"


gatk VariantFiltration \
     -R "${REF}" \
     -V "${VCF_RAW}" \
     -O "${VCF_FILT}" \
     --filter-name "QD_lt2"  --filter-expression "QD < 2.0" \
     --filter-name "FS_gt60" --filter-expression "FS > 60.0" \
     --filter-name "MQ_lt40" --filter-expression "MQ < 40.0" \
     --filter-name "SOR_gt3" --filter-expression "SOR > 3.0" \
     --filter-name "MQRankSum_lt-12" --filter-expression "MQRankSum < -12.5" \
     --filter-name "ReadPos_lt-8"    --filter-expression "ReadPosRankSum < -8.0"

echo -e "\n✓ Pipeline finished — final VCF: ${VCF_FILT}"

echo "Job $SLURM_JOB_ID finished at $(date)"