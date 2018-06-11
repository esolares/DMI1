#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys, os
import numpy as np

try:
    sys.argv[1]
except:
    print 'Invalid sam job file or sam job file missing'
    quit()
else:
    if sys.argv[1] == '':
        infile = sys.argv[1]
    else:
        infile = sys.argv[1]

#extract mapq scores and readnames

myseqlen = 76

def parsecigarstring(mycigarstring):
    mycigars = list()
    begin = 0
    end = 0
    mylen = ''
    for i in range(0,len(mycigarstring)):
        if mycigarstring[i].isdigit():
            mylen = mycigarstring[i] + mylen
        else:
            end = i+1
            mylen = ''
            mycigars.append(mycigarstring[begin:end])
            begin = i+1
    return mycigars

def convertphredscore(s):
    return 1 - (10.0 ** (-(ord(s) - 33.0) / 10.0))

def calculatephred(myphreds,myseqlen):
    myqvs = list()
    for phred in myphreds:
        myqvs.append(convertphredscore(phred))
    myqvscore = np.mean(myqvs)*float(len(myqvs))/float(myseqlen)
    return myqvscore

def calculatecigar(mycigars,myseqlen):
    mycigarscore = 0
    mymatches = 0
    myinsertions = 0
    mydeletions = 0
    mysubs = 0
    for mycigar in mycigars:
        mylen = len(mycigar)
        if mycigar[mylen-1] == 'M':
            mymatches = mymatches + int(mycigar[0:mylen-1])
        elif mycigar[mylen-1] == 'I':
            myinsertions = myinsertions + int(mycigar[0:mylen-1])
        elif mycigar[mylen-1] == 'N':
            print('we found an N')
        elif mycigar[mylen-1] == 'D':
            mydeletions = mydeletions + int(mycigar[0:mylen-1])
        elif mycigar[mylen-1] == 'S':
            print('we found an S')
        elif mycigar[mylen-1] == 'H':
            print('we found an H')
        else:
            print('we found something else: ' + mycigar[0:mylen-1] + mycigar)
    if float(mymatches + myinsertions + mydeletions) == 0:
        mycigarscore = 0
    else:
        mycigarscore = round(float(mymatches)/float(mymatches + myinsertions + mydeletions + mysubs),4)
    return [mymatches,myinsertions,mydeletions,mycigarscore]

def parsecigarscore(mycigar):
    mytempvar2 = calculatecigar(parsecigarstring(mycigar),0)
    #print(str(mytempvar2) + ' ' + str(len(mytempvar2)))
    if len(mytempvar2) == 5:
        myparsedcigarscore = str(mytempvar2[0]) + '\t' + str(mytempvar2[1]) + '\t' + str(mytempvar2[2]) + '\t' + str(mytempvar2[3]) + '\t' + str(mytempvar2[4])
    else:
        myparsedcigarscore = str(mytempvar2[0]) + '\t' + str(mytempvar2[1]) + '\t' + str(mytempvar2[2]) + '\t' + str(mytempvar2[3])
    return myparsedcigarscore

extension = infile.split('.')
if extension[len(extension)-1] == 'sam':
    outfile = infile.replace('.sam','_mapq_scores.txt')
    fout = open(outfile,'w')
    myavgqvs = list()
    for line in open(infile,'r'):
        if line[0] != '@':
            #print(line)
            tempvar = line.strip().split('\t')
            #if tempvar[5] != '*':
                #print(str(tempvar))
            #    fout.write('>' + tempvar[0].split('/')[0] + '\t' + tempvar[4] + '\t' + tempvar[5] + '\t' + parsecigarscore(tempvar[5]) + '\t' + tempvar[8] + '\n')
            myavgqvs.append(calculatephred(tempvar[10],myseqlen))
            fout.write('>' + tempvar[0] + '\t' + str(calculatephred(tempvar[10],myseqlen)) + '\n')
    fout.close()
    print str(np.mean(myavgqvs))
elif extension[len(extension)-1] == 'm4':
    outfile = infile.replace('.m4','_percident.txt')
    fout = open(outfile,'w')
    
    for line in open(infile,'r'):
        if line[0] != '@':
            tempvar = line.replace('\n','').split(' ')
            fout.write('>' + tempvar[0].split('/')[0] + '\t' + tempvar[3] + '\t' + tempvar[12] + '\n')
    fout.close()

