#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
#cd $roidir
#rois=`ls *.nii.gz`
rois=lMFG.nii.gz
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

 for rx in $rois 
    do
    r=`echo $rx | sed "s/.nii.gz//"`
	echo $r
  #  sed -e "s/lsIPS/$r/g" ../../$SUB/analysis/group_lsIPS_hrf.gfeat/design.fsf >group_$r\.fsf
  #  sed -e "s/sub01/$SUB/g" ../../sub01/analysis/group_$r\_hrf.gfeat/design.fsf >group_$r\.fsf 
    mv group_$r\_hrf_ml.gfeat/design.fsf group_$r\_hrf_ml.fsf
    rm -rf group_$r\_hrf_ml.gfeat
    feat group_$r\_hrf_ml.fsf
  #  cp -R run1.feat/reg group_$r\_hrf.gfeat
  #  cp -R run1.feat/reg_standard group_$r\_hrf.gfeat

   # rm *.fsf
done
done
