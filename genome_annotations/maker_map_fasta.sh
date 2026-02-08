#!/bin/bash

p=[isolateID]

#SBATCH --job-name=${p}_maker_map_fasta_trans
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
map_fasta_ids ${p}_contig.map ${p}_NGSEP_polished2.all.maker.transcripts.renamed.fasta

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_maker_map_fasta_trans.txt

