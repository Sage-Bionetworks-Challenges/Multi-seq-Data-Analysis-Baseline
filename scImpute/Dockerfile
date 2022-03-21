
FROM r-base:4.0.3

RUN R -e "install.packages(c('remotes', 'parallel'), repos = 'http://cran.us.r-project.org')"
RUN R -e "remotes::install_github('Vivianstats/scImpute')"

COPY build_baseline.R /build_baseline.R
COPY read_count.R /read_count.R

RUN mkdir -p /data
CMD ["Rscript", "/build_baseline.R", "/data", "/output"]


