#!/usr/bin/env Rscript
suppressMessages(library(scImpute))
suppressMessages(library(parallel))

# overwirte read_count fun of scImpute not to change column names
source("/read_count.R")
environment(read_count) <- asNamespace('scImpute')
assignInNamespace("read_count", read_count, ns = "scImpute")

# use all available cores
ncores <- parallel::detectCores()
print(paste0("Using ", ncores, " Cores"))
args <- commandArgs(trailingOnly = TRUE)

all_prop_names <- c("0_1")
conditions <- c("c1", "c2")

for (p in all_prop_names) {
  for(c in conditions) {
    INPUT <- file.path(args[1], sprintf("dataset1_%s_%s.csv", c, p))
    # output dir must end with "/" to save to right dir
    OUTDIR <- file.path(args[2], sprintf("dataset1_%s_%s/", c, p))
    cat("Imputing experiment:", p, c, "\n")
    scimpute(INPUT, 
             out_dir = OUTDIR, 
             Kcluster = 3,
             ncores = ncores)
    # there are some tmp rdata is also stored
    # only save scimpute_count.csv and remove others
    system(
      sprintf("mv %s %s", 
              file.path(OUTDIR, "scimpute_count.csv"), 
              file.path(args[2], sprintf("dataset1_%s_%s_imputed.csv", c, p))
              )
      )
    unlink(OUTDIR, recursive = TRUE)
    gc();gc() # free up some memories
  }
}

# compress the all prediction csv 
system(sprintf("tar cvzf %s/predictions.tar.gz %s/*.csv", args[2], args[2]))
