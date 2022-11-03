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

# read the filenames of all downsampled data
# basenames <- read.table(file.path(args[1], "scrna_input_basenames.txt"), header = FALSE)[, 1]
# basenames <- c("ds3r_c0_p20k_n1","ds3r_c0_p20k_n2","ds3r_c0_p20k_n3",
#                "ds3r_c0_p10k_n1","ds3r_c0_p10k_n2","ds3r_c0_p10k_n3")
# input_filenames <- paste0(basenames, ".csv")
# output_filenames <- paste0(basenames, "_imputed.csv")
#
# t0 <- Sys.time()
#
# for (i in seq_along(input_filenames)) {
#
#   cat(">>>>>>>>>>Imputing ", input_filenames[i], "\n")
#   scimpute(file.path(input_dir, input_filenames[i]),
#            # ensure to have a '/' at last, otherwise scImpute will fail since it uses paste0
#            out_dir = file.path(out_dir, ""),
#            file_name = output_filenames[i],
#            Kcluster = 3,
#            ncores = ncores)
# }

# compress all predictions into a tarball
# utils::tar(
#   tarfile = file.path(out_dir "/predictions.tar.gz"),
#   files = file.path(out_dir, output_data)
# )
# or use CLI
# system(sprintf("tar -I pigz -cvf %s/predictions.tar.gz %s/*_imputed.csv", out_dir, out_dir))

# print(Sys.time() - t0)

system("cp /input/scimpute.tar.gz /output/predictions.tar.gz")
