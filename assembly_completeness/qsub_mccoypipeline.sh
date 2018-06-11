#!/bin/bash
#$ -N dmelmccoy
#$ -t 7:7
#$ -q epyc,free88i,free72i,free40i,free32i
#$ -pe openmp 1

module load bedtools/2.25.0 jje/jjeutils/0.1a
source ~/.qmbashrc

JOBFILE="assemblies.txt"
ASSEMBLY=$(cat $JOBFILE | head -n $SGE_TASK_ID | tail -n 1)
REFFILE="reffile.txt"

for i in $(cat ${REFFILE})
   do
      REFERENCE=$(basename ${i} .fasta)_test.fasta
      echo "begin Berlin et al pipeline on ${REFERENCE}"
      echo "nucmer --maxmatch --prefix ${PREFIX} ${ASSEMBLY} ${REFERENCE}"
      PREFIX=$(basename ${REFERENCE} .fasta)_$(basename ${ASSEMBLY} .fasta)
      nucmer --maxmatch --prefix ${PREFIX} ${ASSEMBLY} ${REFERENCE}
      delta-filter -q ${PREFIX}.delta > ${PREFIX}.qdelta
      show-coords -lrcTH ${PREFIX}.qdelta > ${PREFIX}.qcoords
      echo "Genes contained within a single contig were counted as:"
      cat ${PREFIX}.qcoords | awk '{if ($7 > 0 && $11 == 100) { print $NF} }' | wc -l
      echo "Genes contained within a single contig at >99% identity:"
      cat ${PREFIX}.qcoords | awk '{if ($7 > 99 && $11 == 100) { print $NF} }' | wc -l
      echo "Genes perfectly reconstructed:"
      cat ${PREFIX}.qcoords | awk '{if ($7 >= 100 && $11 == 100) { print $NF} }' | wc -l
      echo "end Berlin et al pipeline"
done

REFERENCE="dmel-all-chromosome-r5.57.fasta"
PREFIX=$(basename ${ASSEMBLY} .fasta)_$(basename ${REFERENCE} .fasta)
echo "begin McCoy pipeline"
#generate a nucmer alignment, using default parameters
##nucmer ${REFERENCE} ${ASSEMBLY} -p ${PREFIX} > ${PREFIX}_nucmer.log
nucmer -mumref -l 100 -c 1000 --prefix ${PREFIX} $REFERENCE $ASSEMBLY
#filter to select only the best mapping of each contig to the reference
delta-filter ${PREFIX}.delta > ${PREFIX}.qdelta
#display alignments
show-coords -THrcl ${PREFIX}.qdelta
echo "end nucmer McCoy specific pipeline"

echo "begin bedtools McCoy pipeline"
echo "require alignments of at least 99% identity and 1000 bp"
show-coords -THrcl ${PREFIX}.qdelta | awk '{if ($7>99 && $5>1000) print $12"\t"$1"\t"$2"\t"$13"\t"$11}' > ${PREFIX}_nucmer.bed
bedtools merge -i ${PREFIX}_nucmer.bed > ${PREFIX}_nucmer.merge.bed

#begin for loop
echo "begin for loop on chromosomes"
for i in X 2L 2R 3L 3R 4 XHet 2LHet 2RHet 3LHet 3RHet YHet dmel_mitochondrion_genome U
do
    echo "chromosome ${i}"
# count the alignments
    echo "# of alignments:"
    cat ${PREFIX}_nucmer.bed | awk -v i=$i '{if ($1==i) print}' | cut -f4 | sort | uniq | wc -l

# count the gaps: contiguous alignments minus 1, plus 2 for the ends of each alignment
    bedtools complement -g $(basename ${REFERENCE} .fasta).genome -i ${PREFIX}_nucmer.merge.bed > ${PREFIX}_nucmer.complement.bed
    echo "# of gaps:"
    cat ${PREFIX}_nucmer.complement.bed | awk -v i=$i '{if ($1==i) print}' | wc -l

# sum the total aligned length
    echo "alignment length of ${i}:"
    cat ${PREFIX}_nucmer.merge.bed | awk -v i=$i '{if ($1==i) print $3-$2}' | awk '{sum+=$1} END {print sum}'
    printf "\n\n"
done
echo "end for loop on chromosomes"
echo "end bedtools McCoy pipeline"
