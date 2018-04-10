

applywarp -r run1.feat/example_func.nii.gz -i ${roidir}/${rx} -o ppi_timecourse/${r}/${r}  
          --premat=run1.feat/reg/standard2example_func.mat -d float
fslmaths ppi_timecourse/${r}/${r} -thr 0.5 -bin ppi_timecourse/${r}/${r}


for run in 2 3 4 5
do 
flirt -r run1.feat/example_func.nii.gz -i run${run}.feat/example_fun.nii.gz -o example_fun_reg2run1.nii.gz 

applywarp -r run${run}.feat/exmaple_fun_reg2run1.nii.gz -i run${run}/filtered_func_data.nii.gz 
          -o filtered_func_data_reg2run1.nii.gz --premat example_fun_reg2run1.mat

fslmeants -i run${run}.feat/filtered_func_data_reg2run1.nii.gz -o ppi_timecourse/${r}/${r}_run${run}_timecourse.txt 
          -m ppi_timecourse/${r}/${r}.nii.gz
done
