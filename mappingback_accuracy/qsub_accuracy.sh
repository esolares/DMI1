#!/bin/bash
#$ -N korenetalsum
#$ -t 1:7
#$ -q epyc,free88i,free72i,free40i,free32i
#$ -pe openmp 1

source ~/.miniconda
###freebayes 1.1
PATH=$PATH:/data/users/solarese/bin/freebayes/bin

JOBFILE="jobfile.txt"
SEED=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)
REFNAME=$(basename ${SEED} .fasta)
OPTIONS="--threads $NSLOTS"

bowtie-build ${SEED} ${REFNAME}
bowtie -I 200 -X 800 -p 32 -f -l 25 -e 140 --best --chunkmbs 256 -k 1 -S --un=${REFNAME}_unaligned.fasta -q ${REFNAME} -1 pool_combo_1.fastq.gz -2 pool_combo_2.fastq.gz -S ${REFNAME}.sam
samtools view ${OPTIONS} -b ${REFNAME}.sam --reference ${SEED} -o ${REFNAME}.bam
samtools sort ${OPTIONS} ${REFNAME}.bam -o ${REFNAME}_sorted.bam
samtools index -b ${REFNAME}_sorted.bam ${REFNAME}_sorted.bai
freebayes -C 2 -0 -O -q 20 -F 0.5 -z 0.02 -E 0 -X -u -p 1 -b ${REFNAME}_sorted.bam -v ${REFNAME}.vcf -f ${SEED}

echo ${REFNAME}
echo "sam_extract_mapqvals.py"
python sam_extract_mapqvals.py ${REFNAME}.sam
echo "pandas_get_avgmapq.py"
python pandas_get_avgmapq.py ${REFNAME}_mapq_scores.txt
echo "vcf total"
FIRSTNUM=$(wc -l ${REFNAME}.vcf | cut -f1 -d" ")
SECONDNUM=$(grep -c "^#" ${REFNAME}.vcf | cut -f1 -d" ")
echo $((FIRSTNUM - SECONDNUM))

module load bedtools/2.25.0
echo "begin bed create"
bedtools bamtobed -i ${REFNAME}_sorted.bam > ${REFNAME}_sorted.bed
echo "begin bedtools merge"
bedtools merge -i ${REFNAME}_sorted.bed > ${REFNAME}_sorted_merge.bed
echo "begin bedtools fasta dump"
bedtools getfasta -fi ${SEED} -bed ${REFNAME}_sorted.bed -fo ${REFNAME}_aligned.fasta
echo "bedtools ops done"

# sum the total aligned length
echo "alignment length of ${REFNAME}:"
cat ${REFNAME}_sorted_merge.bed | awk '{print $3-$2}' | awk '{sum+=$1} END {print sum}'
printf "\n\n"

