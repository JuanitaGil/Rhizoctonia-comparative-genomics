#!/bin/bash

p=${1};

bowtie2-build ${p}_NGSEP_polished.fa ${p}_NGSEP_polished.fa > ${p}_bowtie2_index.log 2>&1;

