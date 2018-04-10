function extract_TR_data_ecd_raw_1009(sub,run)
% ecding TR changed to the 4th TR. since the ss1 was only presented in
% the 2s and last for 0.5s

%extract testing and localizer task timepoint

basedir='/seastor/caiying/ActionMemory2_m';

addpath /seastor/caiying/toolbox/NIFTI



    %load data
    load(sprintf('%s/behav/results/sub%02d_trial_list.mat',basedir,sub));
    
    %for run=1:5 %zscore within each run
    niifile=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/filtered_func_data_2standard.nii.gz',basedir,sub,run);
    all_data=load_nii_zip(niifile);

    onset_ecd=RSA_ss1(RSA_ss1(:,2)==run,13)-2;
    onset_maint=RSA_ss1(RSA_ss1(:,2)==run,14)-2;
    %end
 
   all_data_final_ecd=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),12);
   all_data_final_maint=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),12);
    
    for vol = 1:12
        if onset_maint(vol)~=0
            tmp=(all_data.img(:,:,:,onset_maint(vol)+1));
            all_data_final_ecd(:,:,:,vol)=tmp-mean(all_data.img,4);
        end
    end
    
    % zscored across all volumes
    % all_data_final_ecd=zscore(all_data_final_ecd,0,4);
    
    filename=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/Extracted_ecd_TR_2standard_raw_1010.nii',basedir,sub,run);
    all_data.img=all_data_final_ecd;
    all_data.hdr.dime.dim(5)=12; % dimension change according to extracted TR
    save_untouch_nii(all_data, filename);
    clear all_data all_data_final_ecd tmp onset vol filename
    sprintf('Extract TR: Sub%02d run%02d is done',sub, run)
    
end 

