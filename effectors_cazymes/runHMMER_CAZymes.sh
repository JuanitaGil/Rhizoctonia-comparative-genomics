#!/bin/bash

p=[isolateID];

hmmsearch --domtblout ${p}_db.out path/to/dbCAN-HMMdb-V8.txt path/to/${p}_NGSEP_polished2.all.maker.proteins.putative_function.fasta > ${p}_hmmer_CAZy.log
