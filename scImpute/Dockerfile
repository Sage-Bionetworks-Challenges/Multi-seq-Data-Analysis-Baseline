
FROM satijalab/seurat:4.0.3

RUN R -e "install.packages(c('remotes'), repos = 'http://cran.us.r-project.org')"
RUN R -e "remotes::install_github('Vivianstats/scImpute')"
RUN apt-get update && apt-get install -y pigz

COPY build_baseline.R /build_baseline.R
COPY read_count.R /read_count.R
COPY write_count.R /write_count.R
COPY scimpute.R /scimpute.R
COPY modified_scimpute_funs.R /modified_scimpute_funs.R

ENTRYPOINT ["Rscript", "/build_baseline.R", "/input", "/output"]


