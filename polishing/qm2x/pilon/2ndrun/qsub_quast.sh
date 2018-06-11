#!/bin/bash
#$ -N quastqm2x
### -t 1-17
#$ -pe openmp 16
#$ -R Y
#$ -q bigmemory,bio,free88i,free72i,epyc,pub64,abio,free64

source ~/.miniconda
quast.py -m 1000 -t 16 *.fasta
