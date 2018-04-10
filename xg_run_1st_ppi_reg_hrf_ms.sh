#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

substar=$1
subend=$2
roi=rsIPS
cond=hrf_ms

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
    
#   for run in 1 
#     do      
#	sed -e "s/sub02/$SUB/g" ../../sub02/analysis/run${run}.feat/design.fsf > run${run}.fsf
#        feat run${run}.fsf
#   done

for dir in run1 run2 run3 run4 run5
do
 cp run1.feat/reg/highres2standard.mat $dir\_$roi\_$cond\.feat/reg/.
 cp run1.feat/reg/highres2standard_warp.nii.gz $dir\_$roi\_$cond\.feat/reg/.
 cp run1.feat/reg/standard*.nii.gz $dir\_$roi\_$cond\.feat/reg/.
 cd $dir\_$roi\_$cond\.feat
 rm -rf reg_standard
 cd reg/
 convert_xfm -omat example_func2standard.mat -concat highres2standard.mat example_func2highres.mat
 applywarp --ref=standard --in=example_func --out=example_func2standard --warp=highres2standard_warp --premat=example_func2highres.mat
 cd ../../
 featregapply $dir\_$roi\_$cond\.feat
done
done

