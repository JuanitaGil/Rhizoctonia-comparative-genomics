#!/bin/bash

#conda activate java11

for f in *fastq.gz
do
/home/jgilbedo/fastqc_v0.11.9/FastQC/fastqc ${f} -o qc_results -t 8 > fastqc.log
done
