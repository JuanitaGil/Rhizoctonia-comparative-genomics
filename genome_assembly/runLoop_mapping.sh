#!/bin/bash

for i in $(cat sampleIDs.txt)
do
./bowtie2_mapping.sh ${i}
done;
