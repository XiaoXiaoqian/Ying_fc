#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
#cd $roidir
#rois=`ls *.nii.gz`
#rois=`ls LOC_new.nii.gz`



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
    

 for run in 1 2 3 4 5
      do      
      echo ${run}
     #   sed -e "s/LOC_new/$r/g"  ../../$SUB/analysis/run${run}_ppi_LOC_new.feat/design.fsf > run${run}_ppi_$r\.fsf
     #  sed -e "s/sub02/$SUB/g" ../../sub02/analysis/run${run}_singletrial.feat/design.fsf > run${run}_single.fsf
     #  sed -e "s/run2/run${run}/g" ../../$SUB/analysis/run2_singletrial.feat/design.fsf > run${run}_single.fsf
     #  feat run${run}_single.fsf
     #  cp -R run${run}.feat/reg run${run}_singletrial\.feat
     #  cp -R run${run}.feat/reg_standard run${run}_singletrial\.feat
       applywarp --ref=run${run}.feat/reg/standard.nii.gz --in=run${run}_singletrial.feat/filtered_func_data.nii.gz --out=run${run}_singletrial.feat/filtered_func_data_standard.nii.gz --warp=run${run}.feat/reg/highres2standard_warp.nii.gz --premat=run${run}.feat/reg/example_func2highres.mat --interp=trilinear -m  run${run}.feat/reg/standard_mask.nii.gz
   done
   
done

