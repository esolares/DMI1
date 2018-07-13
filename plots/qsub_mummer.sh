#!/bin/bash
#$ -N mumbatch
#$ -t 4-4
#$ -pe openmp 1
#$ -R Y
#$ -q bigmemory,bio,pub64,free88i,abio,pub8i,free64

#PATH=/data/users/solarese/bin/MUMmer3.23:$PATH
#source ~/.qmbashrc
#module load gnuplot/4.6.3

REF="dmel-all-chromosome-r6.16.fasta"
PREFIX="flybase"

SGE_TASK_ID=1
SEED=$(ls ISO1*.fa | head -n $SGE_TASK_ID | tail -n 1)

QRY=$SEED
PREFIX=${PREFIX}_$(basename ${SEED} .fa)

echo $SEED
echo $PREFIX

#nucmer -l 100 -c 1000 -d 10 -banded -D 5 -prefix ${PREFIX} ${REF} ${QRY}
#nucmer -prefix ${PREFIX} ${REF} ${QRY}

###nucmer --maxmatch -prefix ${PREFIX} ../${REF} ../${QRY}

mummerplot --fat --layout --filter -p ${PREFIX} ${PREFIX}.delta \
   -R ${REF} -Q ${QRY} --postscript

