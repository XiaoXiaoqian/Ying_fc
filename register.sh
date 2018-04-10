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
   cd ${outputdir}/$SUB/analysis
    
   for run in 1 2 3 4 5
     do    
     echo ${run}
     applywarp --ref=run${run}.feat/reg/standard.nii.gz --in=run${run}.feat/filtered_func_data.nii.gz --out=run${run}.feat/filtered_func_data_standard.nii.gz --warp=run${run}.feat/reg/highres2standard_warp.nii.gz --premat=run${run}.feat/reg/example_func2highres.mat --interp=trilinear -m  run${run}.feat/reg/standard_mask.nii.gz
  
   done
done