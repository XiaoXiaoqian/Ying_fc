for ((sub=14; sub<=28;sub++)) 
do
for r in 1 2 3 4 5
do
  fsl_sub matlab -nodesktop -nosplash -r "run_single_ER($sub,$r);quit;"
done
done
