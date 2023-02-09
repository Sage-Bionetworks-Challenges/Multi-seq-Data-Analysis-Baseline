#!/bin/bash
export INPUT_DIR=$1
export OUPUT_DIR=$2
export NCORES=20 # don't use more than 20 cores

mkdir -p $OUPUT_DIR

basename -a -s .bam $(ls $INPUT_DIR/*.bam) | parallel --max-procs=$NCORES --halt-on-error 2 \
  'macs2 callpeak --keep-dup all -t $INPUT_DIR/{}.bam --nomodel --shift 100 --extsize 200 -n {} --outdir $OUPUT_DIR &&
   perl /01.filter_peaks.pl $OUPUT_DIR/{}_peaks.narrowPeak $OUPUT_DIR/{} 500 &&
   mv $OUPUT_DIR/{}.500.bed $OUPUT_DIR/{}.bed &&
   rm -f $OUPUT_DIR/{}_summits.bed'