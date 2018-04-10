for ((sub=5; sub<=5;sub++)) 
do
for r in 1 2 3 4
do
 # matlab -nodesktop -nosplash -nojvm -r "extract_TR_data_ecd_raw_1003($sub,$r);quit;"
  matlab -nodesktop -nosplash -nojvm -r "extract_TR_data_ecd_raw_23($sub,$r);quit;"
#  fsl_sub matlab -nodesktop -nosplash -nojvm -r "extract_TR_data_z_eachTR($sub,$r);quit;"
#  fsl_sub matlab2013b -nodesktop -nosplash -nojvm -r "extract_TR_data_maint($sub,$r);quit;"
done
done

