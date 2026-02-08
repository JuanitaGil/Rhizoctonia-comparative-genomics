#!/bin/bash

#SBATCH --job-name=interproscan_[isolateID]
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
module load Java/11.0.2
module load interproscan/5.42_78.0

#run
interproscan.sh -appl Pfam -dp -f TSV -goterms -iprlookup -pa -t p -i /path/to/annotations/${p}_NGSEP_polished2.all.maker.proteins.fasta -o ${p}_output.iprscan

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_iprscan.txt

