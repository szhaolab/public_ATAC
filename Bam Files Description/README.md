Each folder contains text files that list the absolute paths to BAM and BAI files.
The BAM/BAI files themselves remain in the ATAC_data/output/ directory.

Folder format \
	•	<SampleID> internal sample identifier (e.g. 1001, 1002) \
 	•	<RunRange> SRR run range included in that sample

Contents \
	•	bam_paths.txt full paths to all *.bam files for this sample \
	•	bai_paths.txt full paths to all *.bam.bai index files

⸻

Example

/ATAC_bam/Graham/1001(1-42)/

	•	Sample ID = 1001
	•	SRR runs = 1–42
	•	bam_paths.txt lists BAMs such as:

/ATAC_data/output/1-10/.../call-filter/shard-0/execution/SRR7650729_1.fastq.srt.nodup.no_chrM_MT.bam \
/ATAC_data/output/1-10/.../call-filter/shard-1/execution/SRR7650730_1.fastq.srt.nodup.no_chrM_MT.bam \
...

