#!/bin/bash

#SBATCH --job-name=maker_ipr_gff_[isolateID]
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
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
ipr_update_gff ${p}_NGSEP_polished2.all.renamed.putative_function.gff ${p}_output.renamed.iprscan > ${p}_NGSEP_polished2.all.renamed.putative_function.domain_added.gff 

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_maker_ipr_update_gff.txt

