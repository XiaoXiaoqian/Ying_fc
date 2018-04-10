#!/bin/sh

basedir='/seastor/caiying/ActionMemory2_m'

substart=$1
subend=$2


for ((m = $substart; m <= $subend; m++))
do
    if [ ${m} -lt 10 ];
    then
       SUB=sub0${m}
    else
        SUB=sub${m}
    fi
    echo $SUB

   ############ make the directory ###############
   cd $basedir

   if [ ! -d $SUB ]
   then
     mkdir $SUB
   fi

   if [ ! -d $SUB/data ]
   then
     mkdir $SUB/data
   fi

   if [ ! -d $SUB/behav ]
   then
      mkdir $SUB/behav
   fi

    if [ ! -d $SUB/analysis ]
    then
       mkdir $SUB/analysis
    fi

    if [ ! -d $SUB/notes ]
    then
      mkdir $SUB/notes
    fi
   


   # now do copy
     cp -rf /seastor/caiying/ActionMemory2/$SUB/data $basedir/$SUB
   

  # for run in 1 2 3 4 5
  # do
  #   filename=`ls $basedir/Data/20150401_02_*/*run0${run}*.nii.gz`
   #  cp $basedir/Data/20150401_02_*/*run0${run}*.nii.gz $basedir/$SUB/data/run${run}.nii.gz
  # done

   # now do the bet
   # bet $basedir/$SUB/data/3d $basedir/$SUB/data/3d_brain -f 0.3 -c 72 94 119
done
