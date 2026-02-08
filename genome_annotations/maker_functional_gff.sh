#!/bin/bash

#SBATCH --job-name=maker_functional_gff_[isolateID]
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=25G
#SBATCH --time=1:00:00
#SBATCH --output=%x-%j.SLURMout

echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "Starting job on `hostname` at `date`"

p=[isolateID]

module purge
module load icc/2018.3.222-GCC-7.3.0-2.30 impi/2018.3.222
module load ifort/2018.3.222-GCC-7.3.0-2.30 
module load MAKER/2.31.10

#run
maker_functional_gff /path/to/uniprot_sprot.fasta /path/to/${p}_output.renamed.blastp ${p}_NGSEP_polished2.all.renamed.gff > ${p}_NGSEP_polished2.all.renamed.putative_function.gff

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_maker_functional_gff.txt

