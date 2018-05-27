#!/bin/bash
#$ -N qmi1onp
### -t 1-1
#$ -pe openmp 2
#$ -R Y
#$ -q bigmemory,free88i,free72i,free40i,free32i,bio,pub64,abio

source ~/.qmbashrc

#REFERENCE
ref="iso1onpa2.contigs.corrected.fasta"
#QUERY
qry="iso1_onp_a2_1kb_30x_LD0_K25_KCOV2_ADAPT0.01_MINOVL35_RMCHIM1_asm.fasta"
prefix=${qry/.fasta/}_${ref/.fasta/}_qm
##opt_l is the n50
opt_l="2900000"
options="-hco 5.0 -c 1.5 -l $opt_l -ml 20000"

#renames headers
#perl -pe 's/>[^\$]*$/">HSeg" . ++$n ."\n"/ge' ${ASM1} > $(basename ${ASM1} .fasta)_new.fasta
#perl -pe 's/>[^\$]*$/">LSeg" . ++$n ."\n"/ge' ${ASM2} > $(basename ${ASM2} .fasta)_new.fasta

#removes escape chars and spaces
cat ${ref} | sed -r 's/[/ =,\t]+/_/g' > $(basename ${ref} .fasta)_new.fasta
cat ${qry} | sed -r 's/[/ =,\t]+/_/g' > $(basename ${qry} .fasta)_new.fasta
qry=$(basename ${qry} .fasta)_new.fasta
ref=$(basename ${ref} .fasta)_new.fasta

nucmer -l 100 -prefix $prefix $ref $qry
delta-filter -i 95 -r -q $prefix.delta > $prefix.rq.delta
quickmerge -d $prefix.rq.delta -q $qry -r $ref $options

