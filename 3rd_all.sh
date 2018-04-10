#!/bin/sh

basedir="/seastor/caiying/ActionMemory2/GroupAnalysis"

substart=$1
subend=$2




for ((m = $substart; m <= $subend; m++))
do
    
    sed -e "s/cope1/cope${m}/" cope1.gfeat/design.fsf > cope${m}.fsf
#cd basedir
    feat  cope${m}.fsf
done

