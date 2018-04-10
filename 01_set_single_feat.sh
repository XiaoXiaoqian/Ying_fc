#!/bin/sh


outputdir="/seastor/caiying/ActionMemory2_m"
cd ${outputdir}

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
   cd ${outputdir}/$SUB/analysis



for run in 1 2 3 4 5
do 
echo ${run}
#sed -e "s/sub01/sub${SUB}/g" -e "s/run1/run${r}/g"  $outputdir/scripts/design_single.fsf > $outputdir/scripts/fsf/single_sub${SUB}.fsf
#feat $outputdir/scripts/fsf/single_sub${SUB}.fsf
sed -e "s/sub01/sub${SUB}/g" -e "s/run1/run${r}/g"  $outputdir/scripts/design_pre.fsf > $outputdir/scripts/fsf/pre_sub${SUB}.fsf
feat $outputdir/scripts/fsf/pre_sub${SUB}.fsf
done
done
