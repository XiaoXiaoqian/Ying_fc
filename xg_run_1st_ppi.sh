#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2_m"

roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis_sub21/roi
cd $roidir
rois=`ls lMFG_exp2_new.nii.gz`



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

   for run in 3 4 5 
      do      
     #   sed -e "s/LOC_new/$r/g"  ../../$SUB/analysis/run${run}_ppi_LOC_new.feat/design.fsf > run${run}_ppi_$r\.fsf
     #   sed -e "s/sub01/$SUB/g" ../../sub02/analysis/run${run}_$r\_ppi_2standard.feat/design.fsf > run${run}_$r\_ppi_2standard.fsf
       sed -e "s/run2/run${run}/g" ../../sub01/analysis/run2_$r\_ppi_2standard.feat/design.fsf > run${run}_$r\_ppi_2standard.fsf
    
    #   cp -R run${run}.feat/reg run${run}_ppi_$r\.feat
    #  cp -R run${run}.feat/reg_standard run${run}_ppi_$r\.feat
   done
   
done
done
