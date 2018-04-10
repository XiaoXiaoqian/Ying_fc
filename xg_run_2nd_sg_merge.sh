
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
#fslmerge -t pe1ls_one_at_time_2standard_$SUB.nii.gz run*_singletrial.feat/stats/pe1ls_one_at_time_2standard.nii.gz
#fslmerge -t func_2standard_$SUB.nii.gz run*_singletrial.feat/filtered*2standard.nii.gz
fslmerge -t Extracted_maint_TR_2standard_raw_678_$SUB.nii.gz run*_singletrial.feat/Extracted_maint_TR_2standard_raw_678.nii
#fslmerge -t Extracted_ecd_TR_2standard_raw_1002_$SUB.nii.gz run*_singletrial.feat/Extracted_ecd_TR_2standard_raw_1002.nii
#fslmerge -t Extracted_ecd_TR_2standard_raw_10082_$SUB.nii.gz run*_singletrial.feat/Extracted_ecd_TR_2standard_raw_10082.nii
#fslmerge -t Extracted_ecd_TR_2standard_raw_10092_$SUB.nii.gz run*_singletrial.feat/Extracted_ecd_TR_2standard_raw_10092.nii
#fslmerge -t Extracted_z_2standard_TR05_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR05.nii
#fslmerge -t Extracted_z_2standard_TR06_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR06.nii
#fslmerge -t Extracted_z_2standard_TR07_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR07.nii
#fslmerge -t Extracted_z_2standard_TR08_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR08.nii
#fslmerge -t Extracted_z_2standard_TR09_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR09.nii
#fslmerge -t Extracted_z_2standard_TR10_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR10.nii
#fslmerge -t Extracted_z_2standard_TR11_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR11.nii
#fslmerge -t Extracted_z_2standard_TR12_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR12.nii
#fslmerge -t Extracted_z_2standard_TR13_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR13.nii
#fslmerge -t Extracted_z_2standard_TR14_$SUB.nii.gz run*_singletrial.feat/Extracted_z_2standard_TR14.nii
#fslmerge -t Extracted_maint_TR_2standard_raw_78_$SUB.nii.gz run*_singletrial.feat/Extracted_maint_TR_2standard_raw_78.nii
done