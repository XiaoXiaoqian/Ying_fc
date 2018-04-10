#!/bin/bash
outputdir="/seastor/caiying/ActionMemory2_m"


#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
#cd $roidir
#rois=`ls *.nii.gz`
rois=lMFG.nii.gz

cd $outputdir

 for rx in $rois  
    

    do
    r=`echo $rx | sed "s/.nii.gz//"`
	echo $r
     mkdir GroupAnalysis_$r
     cd  GroupAnalysis_$r
    sed -e "s/LOC_new/$r/g" ../GroupAnalysis_LOC_new/cope1\.gfeat/design.fsf >group_$r\.fsf
sed -e     
feat group_$r\.fsf
    cd $outputdir
  #  cp script/3rd_all.sh GroupAnalysis_$r
done
