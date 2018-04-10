#!/bin/bash
outputdir="/seastor/caiying/ActionMemory2_m"


#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
#cd $roidir
#rois=`ls *.nii.gz`
rois=rsIPS.nii.gz

cd $outputdir

 for rx in $rois  
    do
 for c in 1 2 3 4 5 6 7 8 9 10
    do
    r=`echo $rx | sed "s/.nii.gz//"`
	echo $r
    echo cope${c}
    mkdir GroupAnalysis_sub21_$r\_hrf
    cd  GroupAnalysis_sub21_$r\_hrf
    sed -e "s/lMFG/$r/g" ../GroupAnalysis_sub21_lMFG_hrf/cope${c}\.gfeat/design.fsf >group_$r_${c}\.fsf
#sed -e "s/cope1/cope${c}/g"   cope1.gfeat/design.fsf >group_$r_cope${c}\.fsf  
feat group_$r_cope${c}.\fsf
#feat group_$r\.fsf
    cd $outputdir
   cp script/3rd_all.sh GroupAnalysis_sub21_$r\_hrf
done
done
