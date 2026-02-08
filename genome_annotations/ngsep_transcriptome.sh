#!/bin/bash

p=isolate_id

#run
java -jar NGSEPcore_4.3.2.jar TranscriptomeAnalyzer -i /path/to/${p}_NGSEP_polished2.all.renamed.putative_function.domain_added.gff -o /path/out/${p}_NGSEP -r /path/to/ref/${p}_NGSEP_polished2.fa > ${p}_NGSEP_transcriptome_analyzer.log 
