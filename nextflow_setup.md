# Project documentation: Nextflow Pipeline
## I. House-keeping 
1. Create repository
2. Update README (see README for details on project).
3. Clone the repository to my local computer
```
git clone git@github.com:bisigit/BCHM_5420-scd-project.git
cd BCHM_5420-scd-project/
```
5. Create a structured directory tree
```
mkdir -p pipeline \
         r_scripts \
         results/
```
6. Create placeholder files
```
touch pipeline/samplesheet.csv
touch .gitignore
```
7. Paste the following in the .gitignore file:
```
*.fastq
*.bam
*.sam
*.vcf
*.log
*.gz
*.zip
*.html
*.png
.DS_Store
work/
.nextflow*
```
8. Push changes to remote Github
```
git init
git add .
git commit -m "Initial project structure with folders and placeholder files"
git push origin main
```
8. Obtain the necessary files for the pipeline using R (see r_scripts folder)

## II. Run Pipeline
1. Run the pipeline
``` 
nextflow run nf-core/differentialabundance \
    --study_name "stroke_in_sickle_cell" \
    --study_type rnaseq \
    --input pipeline/sdc_samplesheet.tsv \
    --matrix pipeline/sdc_counts.tsv \
    --contrasts pipeline/sdc_contrasts.csv \
    --outdir testing_results \
    --features pipeline/sdc_annotations.tsv \
    --features_id_col gene_id \
    --features_name_col gene_name \
    -r dev \
    -profile docker \
    -with-report report.html \
    -with-trace trace.txt
```

2. Navigate to results/tables/differential.
- Obtain the file named "stroke_vs_control_stroke_in_sickle_cell.deseq2.results.tsv" to use for gene set enrichment analysis (GSEA).
- The scripts for GSEA can be found in the r_sripts folder.











