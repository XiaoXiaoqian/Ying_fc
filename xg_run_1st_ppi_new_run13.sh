#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis_sub21/roi
#cd $roidir


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

   for run in 1 2 3
      do      
    #    sed -e "s/lMFG/$r/g"  ../../$SUB/analysis/run${run}_lMFG.feat/design.fsf > run${run}_$r\.fsf
       sed -e "s/sub02/$SUB/g" ../../sub02/analysis/run${run}_$r\_hrf.feat/design.fsf > run${run}_$r\.fsf
   #  sed -e "s/run2/run${run}/g" ../../sub02/analysis/run2_$r\_hrf.feat/design.fsf   > run${run}_$r\.fsf
     feat run${run}_$r\.fsf
     cp -R run${run}.feat/reg run${run}_$r\_hrf.feat
     cp -R run${run}.feat/reg_standard run${run}_$r\_hrf.feat
   done
   
done
done
