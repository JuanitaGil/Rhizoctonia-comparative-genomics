# Comparative genomics of Ceratobasidium species
Genome assemblies and annotations of five Ceratobasidium sp. isolates to conduct comparative genomic studies.
Data consists of Nanopore and Illumina reads

# 1. Sequence quality check
Scripts to calculate sequencing stats for Illumina and Nanopore reads

1.1 Illumina reads

runFastQC.sh

MultiQC

1.2 Nanopore reads

runNanoplot.sh

1.3 k-mer analysis for genome size estimation

kmerAnalysis.R

# 2. Genome assembly
Scripts for all steps in genome assemby.

2.1 Error correction of Nanopore reads

necat_rhizoctonia_config.sh

necat_rhizoctonia_correct-sh

Rhizoc_read_list.txt

Rhizoctonia_config.txt

2.2 Assembly

runGenomeBuilder.sh

runLoop_GenomeBuilder.sh

2.3 Polishing
Polishing was conducted by calling variants to identify sequencing errors and correct in assembly. Therefore, mapping and variant calling steps required.

runBowtieIndex.sh

runLoop_bowtieIndex.sh

bowtie2_mapping.sh

runLoop_mapping.sh

runTandemRepeatsFinder.sh

runVariantCallingNGSEP.sh

2.4 Assembly statistics
Calculate final genome assembly statistics using QUAST

quast_rhizoctonia_ngsep_polished2.sh

# 3. Genome annotations
Genomes were annotated using the MAKER suite and trinotate. 

# 4. Effectors and CAZymes prediction
Scripts for prediction of effectors and CAZymes from annotations and list of secreted proteins. Obtained from the annotation scripts. Secrotome after steps listed in trinotate commands files.
Some R scripts show figures created to compare effector and CAZyme profiles
