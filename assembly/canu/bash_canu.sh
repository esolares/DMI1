#!/bin/bash

module load java/1.8
#PATH=$PATH:/data/users/solarese/bin/canu/Linux-amd64/bin
PATH=$PATH:/data/users/solarese/bin/canu-1.5/Linux-amd64/bin

PREFIX="iso1onpa2"
LONGREADS="iso1_onp_a2_1kb.fastq"
canu -p ${PREFIX} -d ${PREFIX}-auto genomeSize=130m -nanopore-raw ${LONGREADS} -s myspec.spec
