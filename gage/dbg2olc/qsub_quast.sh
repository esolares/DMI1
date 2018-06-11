#!/bin/bash
#$ -N quastgagecanu
### -t 1-17
#$ -pe openmp 32-128
#$ -R Y
#$ -q bigmemory,epyc,free88i,free72i,bio,abio

#source ~/.miniconda
QRY="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm_new_np_pilon_pilon.fasta"
#REF="dmel-all-chromosome-r6.16.fasta"
REF="dmel.mullerelements.noy.fasta"

quast.py -m 1000 -t 1 $QRY --fragmented -R $REF --gage
