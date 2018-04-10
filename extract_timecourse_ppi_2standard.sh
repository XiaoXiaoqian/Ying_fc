
#!/bin/bash


roidir=/seastor/caiying/ActionMemory2_m/GroupAnalysis/roi
cd $roidir
rois=`ls *.nii.gz`
#rois=`ls PaCig.nii.gz`

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
    mkdir ppi_2standard

    #cd ppi_timecourse
    #mkdir $r

    for rx in $rois
    
    do
	roi=`echo $rx|sed "s/.nii.gz//"`
	r=`echo $roi|cut -d '_' -f1-2`
	cope=`echo $roi|cut -d '_' -f2`
	c=`echo $cope|cut -c 5` 
    echo $r
    cd ppi_2standard
    mkdir $r
    cd $subdir/$SUB/analysis

    cp  ${roidir}/${rx} ppi_2standard/${r}
    #applywarp -r run1.feat/example_func.nii.gz -i ${roidir}/${rx} -o ppi_timecourse/${r}/${r}  --premat=run1.feat/reg/standard2example_func.mat -d float

	for run in 1 2 3 4 5
	  do   
	#    fslmaths ppi_timecourse/${r}/${r} -thr 0.5 -bin ppi_timecourse/${r}/${r}
	    fslmeants -i run${run}_singletrial.feat/filtered_func_data_2standard.nii.gz -o ppi_2standard/${r}/${r}_run${run}_timecourse.txt -m ppi_2standard/${r}/${r}.nii.gz
	  done
   done
done


