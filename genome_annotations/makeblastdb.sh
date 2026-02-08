#!/bin/bash

#SBATCH --job-name=blastp_db
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=25G
#SBATCH --time=4:00:00
#SBATCH --output=%x-%j.SLURMout

echo "SLURM_NTASKS: $SLURM_NTASKS"
echo "SLURM_CPUS_ON_NODE: $SLURM_CPUS_ON_NODE"
echo "Starting job on `hostname` at `date`"

module purge
module load BLAST/2.10.0-Linux_x86_64

#run
makeblastdb -dbtype prot -in uniprot_sprot.fasta -input_type fasta -title uniprot_sprot -hash_index -out uniprot_sprot -logfile uniprot_sprot_makeblastdb.log

# Save job info
scontrol show job $SLURM_JOB_ID > job_info_makeblastdb.txt

