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
    
   for run in 1 
     do      
	sed -e "s/sub02/$SUB/g" ../../sub02/analysis/run${run}.feat/design.fsf > run${run}.fsf
       # rm run${run}.feat -rf
        feat run${run}.fsf
   done

#for dir in run3 run4 run5
#do
# cp run1.feat/reg/highres2standard.mat $dir.feat/reg/.
# cp run1.feat/reg/highres2standard_warp.nii.gz $dir.feat/reg/.
# cp run1.feat/reg/standard*.nii.gz $dir.feat/reg/.
# cd $dir.feat/reg
# convert_xfm -omat example_func2standard.mat -concat highres2standard.mat example_func2highres.mat
# applywarp --ref=standard --in=example_func --out=example_func2standard --warp=highres2standard_warp --premat=example_func2highres.mat
# cd ..
# featregapply $dir.feat
#done



done

