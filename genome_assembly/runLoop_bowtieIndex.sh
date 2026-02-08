#!/bin/bash

for i in $(cat sampleIDs.txt)
do
./runBowtie2Index.sh ${i}
done;
