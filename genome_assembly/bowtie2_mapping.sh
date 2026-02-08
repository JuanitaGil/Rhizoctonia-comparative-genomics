#!/bin/bash
p=$1;
x=1000;

 # input files
f1=/path/to/reads/${p}_1.fastq.gz;
f2=/path/to/reads/${p}_2.fastq.gz;
REFERENCE=/path/to/assembly/${p}_NGSEP_polished.fa;

 # jars for java packages
PICARD=/path/to/picard.jar;

 # map the reads and sort the alignment
mkdir ${p}_tmpdir;
bowtie2 --rg-id ${p} --rg SM:${p} --rg PL:ILLUMINA -p 16 -X ${x} -k 3 -t -x ${REFERENCE} -1 ${f1} -2 ${f2} 2> ${p}_polished1_bowtie2.log | java -Xmx8g -jar ${PICARD} SortSam MAX_RECORDS_IN_RAM=1000000 SO=coordinate CREATE_INDEX=true TMP_DIR=${p}_tmpdir I=/dev/stdin O=${p}_bowtie2_polished1_sorted.bam > ${p}_bowtie2_polished1_sort.log 2>&1;
rm -rf ${p}_tmpdir;
