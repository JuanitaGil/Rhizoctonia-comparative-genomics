#!/bin/bash

input=path/to/genomes_folder
output=path/to/outdir
busco -i ${input} -o ${output} -m genome -l agaricomycetes_odb10 -c 16 -f > busco.log 2>&1;
