#!/bin/bash

p=[isolateID];

python path/to/EffectorP-3.0/EffectorP.py -f -o ${p}_effectorp_summary.out -E ${p}_effectors.fasta -N ${p}_nonEffectors.fasta -i path/to/${p}_secretome.fasta > ${p}_effectorp.log
