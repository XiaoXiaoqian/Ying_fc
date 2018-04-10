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

        cp pct*.txt $roidir/results
done





