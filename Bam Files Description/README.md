# BAM Files Description

This repository provides organized BAM/BAI files for four individuals, along with scripts to collect and copy them.

## Repository Structure

- **1001(1-42)**
- **1002(43-83)**
- **1003(84-122)**
- **1004(123-159)**
    - Each folder corresponds to one individual and contains BAM/BAI files for their sequencing runs.
    - The numbers in parentheses indicate the range of runs.

- **SraRunTable.csv**
    - Metadata table that links sequencing runs (SRR IDs) to sample information.
    - This file provides detailed information about the BAM files, including sample identifiers.

- **collect_bam.sh**
    - Script to find and record BAM and BAI file paths from pipeline output directories.
    - Generates `bam_paths.txt` and `bai_paths.txt` inside each individual’s folder.

- **copy_bam_and_bai.sh**
    - Script to copy BAM and BAI files listed in `bam_paths.txt` and `bai_paths.txt` into the same destination folder.

⸻

## Usage

1. **Collect BAM/BAI file paths**

   - Run the collection script to generate path lists (bam_paths.txt and bai_paths.txt) for each individual:

   ```bash
   bash collect_bam.sh
   ```

2. **Copy BAM/BAI files**

   - Use the copy script to copy the files into the target directory (e.g., 1001(1-42)):

   ```bash
   bash copy_bam_and_bai.sh
   ```

Both BAM and BAI files will be copied into the respective individual’s folder.

⸻

### Notes

- The four folders (1001–1004) represent four individuals.
  
- BAM file metadata and sample mapping are described in SraRunTable.csv.  
