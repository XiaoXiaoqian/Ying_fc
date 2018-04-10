
#!/bin/bash
roidir=/seastor/caiying/location_s/location_s1/roi/

#roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi/roi_exp2_21
cd $roidir
rois=`ls *.nii.gz`
#rois=`ls lFP_new.nii.gz`

subdir=/seastor/caiying/ActionMemory2_m
cd $subdir


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
   
    cd $subdir/$SUB/analysis
    mkdir ROI_based_sub21
    
    for rx in $rois
    
    do
	roi=`echo $rx|sed "s/.nii.gz//"`
	r=`echo $roi|cut -d '_' -f1-2`
	cope=`echo $roi|cut -d '_' -f2`
	c=`echo $cope|cut -c 5` 
    cd ROI_based_sub21
    mkdir $r

    cd $subdir/$SUB/analysis

    #applywarp -r run1.feat/example_func.nii.gz -i ${roidir}/${rx} -o ppi_timecourse/${r}/${r}  --premat=run1.feat/reg/standard2example_func.mat -d float
    cp  ${roidir}/${rx} ROI_based_sub21/${r}

	#for run in 1 2 3 4 5
	  #do   
	    #fslmaths ppi_timecourse/${r}/${r} -thr 0.5 -bin ppi_timecourse/${r}/${r}
	    #fslmeants -i run${run}.feat/filtered_func_data.nii.gz -o ppi_timecourse/${r}/${r}_run${run}_timecourse.txt -m ppi_timecourse/${r}/${r}.nii.gz
    fslmeants -i Extracted_maint_TR_2standard_raw_678_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_maint_raw_678.txt 
    fslmeants -i Extracted_maint_TR_2standard_raw_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_maint_raw.txt 
    fslmeants -i Extracted_ecd_TR_2standard_raw_234_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_234.txt 
    fslmeants -i Extracted_ecd_TR_2standard_raw_345_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_345.txt 
    fslmeants -i Extracted_ecd_TR_2standard_raw_456_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_456.txt 
    fslmeants -i Extracted_ecd_TR_2standard_raw_567_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_567.txt 
    #fslmeants -i Extracted_ecd_TR_2standard_raw_1002_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1116.txt   
    #fslmeants -i Extracted_ecd_TR_2standard_raw_1003_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1003.txt 
    # fslmeants -i Extracted_ecd_TR_2standard_raw_1118_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1118.txt 
    # fslmeants -i Extracted_ecd_TR_2standard_raw_1006_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1006.txt 
    # fslmeants -i Extracted_ecd_TR_2standard_raw_1009_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1009.txt 
    # fslmeants -i Extracted_ecd_TR_2standard_raw_1010_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_ecd_raw_1010.txt 
    # fslmeants -i Extracted_maint_TR_2standard_raw_$SUB.nii.gz --showall -m ROI_based_sub21/${r}/${r}.nii.gz -o ROI_based_sub21/${r}/${r}_item_maint_raw.txt 
  #fslmeants -i Extracted_z_2standard_TR03_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR03.txt 
  #fslmeants -i Extracted_z_2standard_TR04_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR04.txt 
  #fslmeants -i Extracted_z_2standard_TR05_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR05.txt 
  #fslmeants -i Extracted_z_2standard_TR06_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR06.txt 
  #fslmeants -i Extracted_z_2standard_TR07_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR07.txt 
  #fslmeants -i Extracted_z_2standard_TR08_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR08.txt 
  #fslmeants -i Extracted_z_2standard_TR09_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR09.txt 
 # fslmeants -i Extracted_z_2standard_TR10_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR10.txt 
 # fslmeants -i Extracted_z_2standard_TR11_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR11.txt 
  #fslmeants -i Extracted_z_2standard_TR12_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR12.txt 
 # fslmeants -i Extracted_z_2standard_TR13_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR13.txt 
#  fslmeants -i Extracted_z_2standard_TR14_$SUB.nii.gz --showall -m ROI_based_sub/${r}/${r}.nii.gz -o ROI_based_sub/${r}/${r}_item_TR14.txt 

# done  
   done
done


