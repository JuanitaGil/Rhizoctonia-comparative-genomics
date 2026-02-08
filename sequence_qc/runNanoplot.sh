#!/bin/bash

# Set variables
threads=8
outdir=/path/to/outdir

source activate nanoplot

for id in $(cat isolate_ids.txt)
do
input=${id}_nanopore.fastq.gz
NanoPlot -t ${threads} -o ${outdir} -p ${id} --N50 --fastq ${input}
done
