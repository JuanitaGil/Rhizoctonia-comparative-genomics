# Rhizoctonia-comparative-genomics
Genome assemblies and annotations of five Ceratobasidium sp. isolates and one Rhizoctonia zeae isolate to conduct comparative genomic studies.
Data consists of Nanopore and Illumina reads

# 1. Sequence quality check
#1.1 Illumina reads
runFastQC.sh
MultiQC

#1.2 Nanopore reads
runNanoplot.sh

#1.3 k-mer analysis for genome size estimation
kmerAnalysis.R

# 2. Genome assembly
#2.1 Error correction of Nanopore reads

#2.2 Assembly

#2.3 Polishing
