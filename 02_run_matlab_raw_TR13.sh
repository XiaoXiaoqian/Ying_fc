for ((sub=1; sub<=3;sub++)) 
do
for r in 1 2 3 4 5
do
  matlab -nodesktop -nosplash -nojvm -r "extract_TR_data_ecd_raw_23($sub,$r);quit;"
 #  fsl_sub matlab -nodesktop -nosplash -nojvm -r "extract_TR_data_z_eachTR($sub,$r);quit;"
#  fsl_sub matlab2013b -nodesktop -nosplash -nojvm -r "extract_TR_data_maint($sub,$r);quit;"
done
done

