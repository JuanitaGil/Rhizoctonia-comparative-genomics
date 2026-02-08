#!/bin/bash

p=[isolateID]

#SBATCH --job-name=maker_${p}
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=25G
#SBATCH --time=1:00:00
#SBATCH --output=%x-%j.SLURMout

echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "Starting job on `hostname` at `date`"

module purge
module load icc/2018.3.222-GCC-7.3.0-2.30 impi/2018.3.222
module load ifort/2018.3.222-GCC-7.3.0-2.30 
module load MAKER/2.31.10

#run
fasta_merge -d /path/to/annotation/${p}_NGSEP_polished2_master_datastore_index.log

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_maker_fasta_merge.txt

