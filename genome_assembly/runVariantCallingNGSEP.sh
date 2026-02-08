#!/bin/bash
p=$1;

 # input files
b=/path/to/${p}_bowtie2_polished1_sorted.bam;
REFERENCE=/path/to/genomes/${p}_NGSEP_polished.fa;
STRs=/path/to/strs/${p}_polished1_trf_2_7_7_80_10_20_50_filtered.txt;

 # jars for java packages
NGSEP=/path/to/NGSEPcore_4.3.1.jar;

 # call variants
java -Xmx32g -jar ${NGSEP} SingleSampleVariantsDetector -maxBaseQS 30 -minQuality 40 -runRep -runRD -runRP -knownSTRs ${STRs} -sampleId ${p} -r ${REFERENCE} -i ${b} -o ${p}_NGSEP2 > ${p}_NGSEP2.log 2>&1;
