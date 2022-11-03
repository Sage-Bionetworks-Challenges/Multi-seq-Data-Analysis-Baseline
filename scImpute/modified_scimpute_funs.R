# overwirte some functions of scimpute package to
# 1. speed up with fread/fwrite
# 2. prevent from changing column names
source("read_count.R")
environment(read_count) <- asNamespace('scImpute')
assignInNamespace("read_count", read_count, ns = "scImpute")
source("/write_count.R")
environment(write_count) <- asNamespace('scImpute')
assignInNamespace("write_count", write_count, ns = "scImpute")
source("/scimpute.R")
environment(scimpute) <- asNamespace('scImpute')
assignInNamespace("scimpute", scimpute, ns = "scImpute")