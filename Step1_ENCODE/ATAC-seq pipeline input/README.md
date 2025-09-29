# ATAC-seq pipeline input JSON files

This folder contains input JSON configuration files for running the **ENCODE ATAC-seq pipeline** using Cromwell/Caper.

---

## File naming

- Files are named as:

atac_input_1.json
atac_input_2.json
atac_input_3.json
…

- Each JSON corresponds to one pipeline run, typically containing up to **10 replicates** (10 pairs of FASTQ files for paired-end sequencing).
- If more than 10 replicates exist for one sample, the sample is split across multiple JSON files (e.g., `atac_input_1.json` for reps 1–10, `atac_input_2.json` for reps 11–20, etc.).

---

## Structure of JSON

Each JSON file defines:
- **Reference genome**  
```json
"atac.genome_tsv": "/path/to/hg38.tsv"

Points to a .tsv file that includes reference FASTA, index, and annotation.
	•	Paired-end flag

"atac.paired_end": true


	•	FASTQ files
Each replicate is defined by R1 and R2 files:

"atac.fastqs_rep1_R1": ["/path/to/SRR7650729_1.fastq"],
"atac.fastqs_rep1_R2": ["/path/to/SRR7650729_2.fastq"]


	•	Optional flags

"atac.enable_idr": false,
"atac.enable_xcor": false,
"atac.true_rep_only": true,
"atac.align_only": true

	•	Disable IDR and cross-correlation steps
	•	Use only true replicates
	•	Run alignment only (skip peak calling and downstream analysis)

⸻

Example usage

Submit a job with Caper:

caper hpc submit atac.wdl \
  -i /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/atac_input_16.json \
  --singularity \
  --leader-job-name atac-16 \
  --local-loc-dir /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/tmp_user/151-159 \
  --local-out-dir  /dartfs/rc/lab/S/Szhao/qiruiz/ATAC_data/output/151-159


⸻

Notes
	•	Each JSON contains at most 10 replicates.
	•	Replicates beyond 10 are distributed across multiple JSON files to avoid overly large input lists.

