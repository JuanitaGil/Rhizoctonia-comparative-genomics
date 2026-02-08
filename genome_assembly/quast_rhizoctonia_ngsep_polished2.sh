#!/bin/bash

#run
quast.py -t 32 --fungus /path/to/polished_genomes/AG-A_NGSEP_polished2.fa /path/to/polished_genomes/AG-E_NGSEP_polished2.fa /path/to/polished_genomes/AG-K_NGSEP_polished2.fa /path/to/polished_genomes/CAG-3_NGSEP_polished2.fa /path/to/polished_genomes/CAG-6_NGSEP_polished2.fa -o ngsep_polished2_quast > ngsep_polished2_quast.log 2>&1

