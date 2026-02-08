#!/bin/bash

for i in $(cat sampleIDs.txt)
do
./runGenomeBuilder.sh ${i}
done;
