function extract_TR_data_maint_raw(sub,run)
%789tr

basedir='/seastor/caiying/ActionMemory2_m';

addpath /seastor/caiying/toolbox/NIFTI


%% loop for subs
%localizer

    %load data
    load(sprintf('%s/behav/results/sub%02d_trial_list.mat',basedir,sub));
    
    %for run=1:5 %zscore within each run
    niifile=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/filtered_func_data_2standard.nii.gz',basedir,sub,run);
    all_data=load_nii_zip(niifile);
    % normalize along the time dimension (z-scored within scan)
    %all_data.img(:,:,:,[1:288])=zscore(all_data.img(:,:,:,[1:288],0,4);
    %all_data.img(:,:,:,:)=zscore(all_data.img(:,:,:,:),0,4);  
    onset_ecd=RSA_ss1(RSA_ss1(:,2)==run,13);
    onset_maint=RSA_ss1(RSA_ss1(:,2)==run,14);
    %end
 
   all_data_final_ecd=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),12);
   all_data_final_maint=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),12);
    
    for vol = 1:12
        if onset_ecd(vol)~=0
            if onset_maint(vol)~=289
            tmp=(all_data.img(:,:,:,onset_maint(vol))+all_data.img(:,:,:,(onset_maint(vol)+1))+all_data.img(:,:,:,(onset_maint(vol)+2)))/3;
            else
            tmp=(all_data.img(:,:,:,onset_maint(vol))+all_data.img(:,:,:,(onset_maint(vol)+1)))/2;
             end
            % demean in each run
             all_data_final_maint(:,:,:,vol)=tmp-mean(all_data.img,4);
        end
    end
    
    % zscored across all volumes
    %all_data_final_maint=zscore(all_data_final_maint,0,4);
    
    filename=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/Extracted_maint_TR_2standard_raw.nii',basedir,sub,run);
    all_data.img=all_data_final_maint;
    all_data.hdr.dime.dim(5)=12; % dimension change according to extracted TR number
    save_untouch_nii(all_data, filename);
    clear all_data all_data_final_mait tmp onset vol filename
    sprintf('Extract TR: Sub%02d run%02d is done',sub, run)
    
    end % sub

