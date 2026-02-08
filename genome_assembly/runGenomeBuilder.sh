#!/bin/bash
p=$1;

 # input files
GENOME=/path/to/genome/${p}_NGSEP_polished.fa;
VCF=/path/to/variants_file/${p}_NGSEP.vcf;

 # jars for java packages
NGSEP=/path/to/NGSEPcore_4.3.1.jar;

 # call variants
java -Xmx32g -jar ${NGSEP} IndividualGenomeBuilder -i ${GENOME} -v ${VCF} -ploidy 1 -o ${p}_NGSEP_polished2.fa > ${p}_NGSEP_polishing2.log 2>&1;
