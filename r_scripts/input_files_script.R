# Making the sample sheet, contrasts.csv and gene_annotations.tsv files

library(readr)
library(dplyr)
library(biomaRt)

############# Fixing the count matrix and sample sheet ##########

# 1. Import count matrix
count_matrix <- read.delim("GSE248760_raw_counts.txt")

# 2. Extract sample names and conditions from the count matrix
sample_names <- as.character(colnames(count_matrix [1, -1]))     
conditions <- as.character(count_matrix[1, -1])       

# 3. Extract count matrix
count_matrixX <- count_matrix[-c(1), ]                # Remove first two rows
colnames(count_matrixX) <- c("GeneID", sample_names)

# 4. Ensure numeric counts
count_matrixXX <- count_matrixX %>%
  mutate(across(-GeneID, as.numeric))    

# 5.Create metadata.tsv
metadata <- data.frame(
  sample = sample_names,
  condition = conditions
)

# 6. Add Sample names



# 6. Save files
write_tsv(count_matrixXX, "sdc_counts.tsv")
write_tsv(metadata, "sdc_samplesheet.tsv")


################ Making contrasts file ##############
# 1. Create contrast definition
contrast_df <- data.frame(
  id = "stroke_vs_control",
  variable = "condition",
  reference = "C",
  target = "IS",
  blocking = ""
)

# 2. Save the file
write_csv(contrast_df, "sdc_contrasts.csv")


################# Map Ensembl IDs ##################
# 1. Get set
mart <- useMart("ensembl", dataset = "hsapiens_gene_ensembl")

# 2. Get gene IDs from counts matrix (pull only first column)
ensembl_ids <- read_tsv("sdc_counts.tsv", col_names = TRUE, n_max = 1) %>%
  pull(1)  

# 3. Map
annotations <- getBM(
  attributes = c("ensembl_gene_id", "hgnc_symbol"),
  filters = "ensembl_gene_id",
  values = ensembl_ids,
  mart = mart
)

# 4. Rename columns to match nf-core expectation
colnames(annotations) <- c("gene_id", "gene_name")

# 5. Save file
write_tsv(annotations, "sdc_annotations.tsv")



############# move to appropiate folder ###########
#bash
explorer.exe .
