#!/bin/bash

#SBATCH --job-name=blastp_[isolateID]
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=25G
#SBATCH --time=2:00:00
#SBATCH --output=%x-%j.SLURMout

p=[isolateID]

echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "Starting job on `hostname` at `date`"

module purge
module load BLAST/2.10.0-Linux_x86_64

#run
blastp -query path/to/annotations/${p}_NGSEP_polished2.all.maker.proteins.renamed.fasta -db /path/to/uniprot_sprot -num_threads 16 -evalue 1e-6 -max_hsps 1 -max_target_seqs 1 -outfmt 6 -out ${p}_output.renamed.blastp

# Save job info
scontrol show job $SLURM_JOB_ID > ${p}_job_info_blastp.txt

