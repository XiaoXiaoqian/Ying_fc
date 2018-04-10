    #!/bin/bash   
    outputdir="/seastor/caiying/ActionMemory2"
    roidir=/seastor/caiying/ActionMemory2/GroupAnalysis/roi
    cd $roidir
    rois=`ls *.nii.gz`
    pestart=1
    peend=144

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

        for rx in $rois 
        do
        r=`echo $rx | sed "s/.nii.gz//"`
        echo $r
        for run in 1 2 3 4 5 
          do
          cd run${run}.feat/stats

          # rename all the pe*nii.gz
          for ((i = $pestart; i <= $peend; i++))
          do
          peid_tmp=`echo pe$i|cut -d '.' -f 1`
          peid=`echo $peid_tmp|cut -d 'e' -f 2`
          if [ ${peid} -lt 10 ];
          then
           PE=pe00${peid}
           mv pe$i.nii.gz $PE.nii.gz
          elif [ ${peid} -gt 9 ] && [ ${peid} -lt 100 ];
          then   
           PE=pe0${peid}
           mv pe$i.nii.gz $PE.nii.gz
          else
           PE=pe${peid}
          fi
          echo $PE
          #  mv pe$i.nii.gz $PE.nii.gz
          done
    


          #create merged image for 16s
           fslmerge -t all.nii.gz pe*.nii.gz
           cd $outputdir/$SUB/analysis
           echo "starting avwmaths..."
           fslmaths run${run}.feat/stats/all.nii.gz -div run${run}.feat/mean_func.nii.gz -mul $ppheight pctchange_data 
           echo "begin avwmaths..."   
           fslmeants -i pctchange_data -o pct_run${run}_$r\.txt -m ppi_timecourse/$r/$r\.nii.gz 
         done 
           paste pct_run*_$r\.txt > pct_$SUB\_$r\.txt
           rm pct_run*.txt
           rm *.nii.gz
        done
        cp pct*.txt $roidir/results
done





