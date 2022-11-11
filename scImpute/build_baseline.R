#!/usr/bin/env Rscript
suppressMessages(library(scImpute))

# overwrite some scimpute functions to speed up
source("/modified_scimpute_funs.R")

# set cores to use for palatalization
ncores <- 20

# read arguments
args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
out_dir <- args[2]

# Get input files
input_filenames <- list.files(input_dir, pattern = "*.csv")
# Retrieve the filenames without ext of all downsampled data
filenames <- tools::file_path_sans_ext(input_filenames)
# Add "_imputed" to create prediction/output filenames
output_filenames <- paste0(filenames, "_imputed.csv")

for (i in seq_along(input_filenames)) {
    scimpute(file.path(input_dir, input_filenames[i]),
        # ensure to have a '/' at last, otherwise scImpute will fail since it uses paste0
        out_dir = file.path(out_dir, ""),
        file_name = output_filenames[i],
        Kcluster = 3,
        ncores = ncores
    )
}

system(sprintf("tar -I pigz -cvf %s/predictions.tar.gz %s/*_imputed.csv", out_dir, out_dir))

# Quick getting results from scimpute - for admin purpose
# system("cp /input/scimpute.tar.gz /output/predictions.tar.gz")
