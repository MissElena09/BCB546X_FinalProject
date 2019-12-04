#!/bin/bash

# Copy/paste this job script into a text file and submit with the command:
#    sbatch thefilename
# job standard output will go to the file slurm-%j.out (where %j is the job ID)

#SBATCH --time=24:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=12   # 12 processor core(s) per node 
#SBATCH --mem=100G   # maximum memory per node
#SBATCH --job-name="reads_isolation_our_group"
#SBATCH --mail-user=zlozier@iastate.edu   # email address
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL

# LOAD MODULES, INSERT CODE, AND RUN YOUR PROGRAMS HERE

module load blast-plus

cut -f 2 /ptmp/zlozier/b_combined_pmv_1.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747746_1db/SRX747746_1.fasta >> /ptmp/zlozier/b_combined_pmv.fasta; done; & cut -f 2 /ptmp/zlozier/b_combined_spmv_1.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747746_1db/SRX747746_1.fasta >> /ptmp/zlozier/b_combined_spmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_pmv_pmv_1.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747740_1db/SRX747740_1.fasta >> /ptmp/zlozier/b_pmv_pmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_pmv_spmv_1.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747740_1db/SRX747740_1.fasta >> /ptmp/zlozier/b_pmv_spmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_combined_pmv_1.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747746_1db/SRX747746_1.fastq >> /ptmp/zlozier/b_combined_pmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_combined_spmv_1.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747746_1db/SRX747746_1.fastq >> /ptmp/zlozier/b_combined_spmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_pmv_pmv_1.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747740_1db/SRX747740_1.fastq >> /ptmp/zlozier/b_pmv_pmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_pmv_spmv_1.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747740_1db/SRX747740_1.fastq >> /ptmp/zlozier/b_pmv_spmv.fastq; done;

cut -f 2 /ptmp/zlozier/b_combined_pmv_2.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747746_2db/SRX747746_2.fasta >> /ptmp/zlozier/b_combined_pmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_combined_spmv_2.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747746_2db/SRX747746_2.fasta >> /ptmp/zlozier/b_combined_spmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_pmv_pmv_2.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747740_2db/SRX747740_2.fasta >> /ptmp/zlozier/b_pmv_pmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_pmv_spmv_2.out | sort | uniq | while read line; do grep -A1 -w "$line" /ptmp/zlozier/SRX747740_2db/SRX747740_2.fasta >> /ptmp/zlozier/b_pmv_spmv.fasta; done; &cut -f 2 /ptmp/zlozier/b_combined_pmv_2.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747746_2db/SRX747746_2.fastq >> /ptmp/zlozier/b_combined_pmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_combined_spmv_2.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747746_2db/SRX747746_2.fastq >> /ptmp/zlozier/b_combined_spmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_pmv_pmv_2.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747740_2db/SRX747740_2.fastq >> /ptmp/zlozier/b_pmv_pmv.fastq; done; &cut -f 2 /ptmp/zlozier/b_pmv_spmv_2.out | sort | uniq | while read line; do grep --no-group-separator -A1 -w "$line" /ptmp/zlozier/SRX747740_2db/SRX747740_2.fastq >> /ptmp/zlozier/b_pmv_spmv.fastq; done;