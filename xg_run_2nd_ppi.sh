#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
cd $roidir
rois=`ls *.nii.gz`
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

 for rx in $rois 
    do
    r=`echo $rx | sed "s/.nii.gz//"`
	echo $r
    sed -e "s/LOC_new/$r/g" ../../$SUB/analysis/group_LOC_new\.gfeat/design.fsf >group_$r\.fsf
   # sed -e "s/sub01/$SUB/g" ../../sub01/analysis/group_$r\.gfeat/design.fsf >group_$r\.fsf 
    feat group_$r\.fsf
   # rm *.fsf
done
done
