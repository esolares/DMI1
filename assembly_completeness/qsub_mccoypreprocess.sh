#!/bin/bash
#$ -N dmelmccoypre
#$ -t 1:4
#$ -q epyc,free88i,free72i,free40i,free32i
#$ -pe openmp 1

JOBFILE="reffile.txt"
REFERENCE=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)

echo ${REFERENCE}
while read i
   do
      echo $i | cut -d" " -f1 >> $(basename ${REFERENCE} .fasta)_test.fasta
done <${REFERENCE}
