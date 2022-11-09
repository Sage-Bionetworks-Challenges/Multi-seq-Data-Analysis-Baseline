FROM python:3.9.1-slim-buster

RUN apt-get update && apt-get install -y python3-dev gcc parallel pigz bedtools
RUN echo 'will cite' | parallel --citation || true
RUN python -m pip install --upgrade pip
RUN pip install macs2 

COPY run_model.sh /run_model.sh
COPY 01.filter_peaks.pl /01.filter_peaks.pl

ENTRYPOINT ["bash", "/run_model.sh", "/input", "/output"]
