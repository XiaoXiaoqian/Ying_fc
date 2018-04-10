
#!/bin/bash


roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
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
    mkdir ROI_based

    #cd ppi_timecourse
    #mkdir $r

    for rx in $rois
    
    do
	roi=`echo $rx|sed "s/.nii.gz//"`
	r=`echo $roi|cut -d '_' -f1-2`
	cope=`echo $roi|cut -d '_' -f2`
	c=`echo $cope|cut -c 5` 
    cd ROI_based
    mkdir $r

    cd $subdir/$SUB/analysis

    #applywarp -r run1.feat/example_func.nii.gz -i ${roidir}/${rx} -o ppi_timecourse/${r}/${r}  --premat=run1.feat/reg/standard2example_func.mat -d float
    cp  ${roidir}/${rx} ROI_based/${r}

	#for run in 1 2 3 4 5
	  #do   
	    #fslmaths ppi_timecourse/${r}/${r} -thr 0.5 -bin ppi_timecourse/${r}/${r}
	    #fslmeants -i run${run}.feat/filtered_func_data.nii.gz -o ppi_timecourse/${r}/${r}_run${run}_timecourse.txt -m ppi_timecourse/${r}/${r}.nii.gz
        # fslmeants -i Extracted_ecd_TR_2standard_$SUB.nii.gz --showall -m ROI_based/${r}/${r}.nii.gz -o ROI_based/${r}/${r}_item_ecd.txt 
         fslmeants -i Extracted_maint_TR_2standard_$SUB.nii.gz --showall -m ROI_based/${r}/${r}.nii.gz -o ROI_based/${r}/${r}_item_maint.txt 
	 # done  
   done
done


