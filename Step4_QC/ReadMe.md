```{bash}
bcftools stats /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/call_1001/1001.hc.raw.vcf \
  > /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/call_1001/1001.vcf.stats

plot-vcfstats -p /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/call_1001/vcf_plots \
  /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_bam/Individual1/call_1001/1001.vcf.stats
```
