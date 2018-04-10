#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
#cd $roidir
#rois=`ls *.nii.gz`
rois=rsIPS.nii.gz
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
    sed -e "s/lMFG/$r/g" ../../$SUB/analysis/group_lMFG_hrf_ms.gfeat/design.fsf >group_$r\_ms.fsf
 #   sed -e "s/sub01/$SUB/g" ../../sub01/analysis/group_$r\_hrf_ms.gfeat/design.fsf >group_$r\_ms.fsf
    feat group_$r\_ms.fsf
    cp -R run1.feat/reg group_$r\_hrf_ms.gfeat
    cp -R run1.feat/reg_standard group_$r\_hrf_ms.gfeat

   # rm *.fsf
done
done
