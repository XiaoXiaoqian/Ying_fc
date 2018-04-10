#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

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

   cd $outputdir/$SUB/analysis
 
    sed -e "s/sub01/$SUB/g" ../../sub01/analysis/group.gfeat/design.fsf >group.fsf
    feat group.fsf

   done  
# rm *.fsf
#done

