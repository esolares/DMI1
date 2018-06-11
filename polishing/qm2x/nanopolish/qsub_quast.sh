#!/bin/bash
#$ -N quastcanuserial
### -t 1-17
#$ -pe openmp 8
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,pub64,abio,free64,pub8i

#source ~/.mybashrc
source ~/.miniconda
#quast.py -m 1000 -t 8 *m/iso1o*-auto/iso1onp*.contigs.fasta canu15filtered*/iso1*/*contigs.fasta
quast.py -m 1000 -t 8 *.fasta
