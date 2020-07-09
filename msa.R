library(Biostrings)
library(stringr)
library(DECIPHER)
library(ape)

# Function for alignment with masked homoplasic sites

mask_sites <- c(187, 1059, 2094, 3037, 3130, 6990, 8022, 10323, 10741, 11074, 13408, 14786, 19684, 20148, 21137, 24034, 24378, 25563, 26144, 26461, 26681, 28077, 28826, 28854, 29700, 4050, 13402, 11083, 15324, 21575)

align_get <- function(file) {
  
  fastas <- readDNAStringSet(file)
  fastas_ungapped <- RemoveGaps(fastas, removeGaps = "all", processors = cores)
  fasta_align <- AlignSeqs(fastas_ungapped, iterations = iters, refinements = refs, processors = cores)
  fasta_mat <- as.matrix(fasta_align)
  fasta_bin <- as.DNAbin(fasta_mat)
  fasta_ungapped <- del.colgapsonly(fasta_bin, threshold = 0.95)
  fasta_string <- fasta_ungapped %>% as.list %>% as.character %>% lapply(., paste0, collapse = "") %>% unlist %>% DNAStringSet
  align_mat <- as.matrix(fasta_string)
  align_mat_sub <- align_mat[, -mask_sites]
  align_mat_bin <- as.DNAbin(align_mat_sub)
  align_masked <- align_mat_bin %>% as.list %>% as.character %>% lapply(., paste0, collapse = "") %>% unlist %>% DNAStringSet
  return(align_masked)
  
}

# Load args

args <- commandArgs(trailingOnly = TRUE)

fasta_file <- as.character(args[1])
iters <- as.numeric(args[2])
refs <- as.numeric(args[3])
cores <- as.numeric(args[4])

# Process, align, and remove homoplasic sites 

fasta_aligned <- align_get(fasta_file)

# Output alignment 

if (!dir.exists("out")) {
  dir.create("out")
}

file_name_no_ext <- str_split_fixed(fasta_file, fixed("."), 2)[1]

file_name_no_ext_whitespace <- gsub(" ", "", file_name_no_ext, fixed = TRUE)

writeXStringSet(fasta_aligned, file = paste0("out/", file_name_no_ext_whitespace, "_aligned.fasta"))