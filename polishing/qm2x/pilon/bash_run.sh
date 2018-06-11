#!/bin/bash
#order of ops only. do not execute
qsub qsub_bowtiebuild.sh
qsub qsub_bowtie2.sh
qsub qsub_samtools.sh
qsub qsub_pilon.sh

