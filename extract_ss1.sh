#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"
cd ${outputdir}

substar=$1
subend=$2

for ((sub = $substar; sub <= $subend; sub++))
do
   if [ ${sub} -lt 10 ];
    then
       SUB=sub0${sub}
    else
        SUB=sub${sub}
    fi
   echo $SUB
   cd ${outputdir}/$SUB/behav

for run in 1 2 3 4 5
do 
echo ${run}
 paste run${run}_*1.txt >run${run}_ss1.txt
done
done