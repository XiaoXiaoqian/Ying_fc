#!/bin/bash

outputdir="/seastor/caiying/ActionMemory2"

roidir=/seastor/caiying/ActionMemory2/GroupAnalysis/roi
cd $roidir
#rois=`ls *.nii.gz`
rois=`ls rMT.nii.gz`

substar=$1
subend=$2
ppheight=41;

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
    rm *.fsf
    rm *.txt 
    
  for rx in $rois 
    do
    r=`echo $rx | sed "s/.nii.gz//"`
	echo $r
      for run in 1 
       #echo $run 
      
       do
          for ((tt = 1; tt <= 144; tt++))
             do      
             echo "starting avwmaths $tt"
              fslmaths run${run}.feat/stats/pe${tt}.nii.gz -div run${run}.feat/mean_func.nii.gz -mul $ppheight pctchange_data    
              fslmeants -i pctchange_data -o pct_pe${tt}_run${run}_$r\.txt -m ppi_timecourse/$r/$r\.nii.gz 	
             done
             cat pct_pe*_run${run}_$r\.txt > pct_time_run${run}_$r.txt
     done
       paste pct_time_run*_$r\.txt > pct_$SUB\_$r\.txt
       
     *  rm pct_time_run*.txt
     *  rm pct_pe*.txt
     *  cp -R pct_sub*.txt $roidir/results 
  done
done