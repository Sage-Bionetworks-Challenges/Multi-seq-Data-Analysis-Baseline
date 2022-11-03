write_count <-
  function (count_imp, filetype, out_dir, type, genelen, file_name)
  {
    totalCounts_by_cell = readRDS(paste0(out_dir, "totalCounts_by_cell.rds"))
    count_imp = sweep(count_imp, MARGIN = 2, totalCounts_by_cell/10^6, 
                      FUN = "*")
    if(type == "TPM"){
      count_imp = sweep(count_imp, 1, genelen, FUN = "/")
    }
    count_imp = round(count_imp, digits = 2)
    if (filetype == "csv") {
      # Edits: use fwrite and custom out filename
      # data.table(count_imp, file = paste0(out_dir, "scimpute_count.csv"))
      # replace with fwrite to speed up
      data.table::fwrite(data.table::as.data.table(count_imp, keep.rownames = ""), 
                         file.path(out_dir, file_name))
    }
    else if (filetype == "txt") {
      write.table(count_imp, file = paste0(out_dir, "scimpute_count.txt"), 
                  quote = FALSE)
    }else if (filetype == "rds") {
      saveRDS(count_imp, file = paste0(out_dir, "scimpute_count.rds"))
    }else {
      print("filetype can be 'csv', 'txt', or 'rds'!")
      stop()
    }
    return(0)
  }