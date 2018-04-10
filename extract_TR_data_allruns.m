function extract_TR_data(subs)
%extract testing and localizer task timepoint

basedir='/seastor/caiying/ActionMemory2_m';

addpath /seastor/caiying/toolbox/NIFTI

subs=1;

%% loop for subs
%localizer
for sub=subs
    %load data
    load(sprintf('%s/behav/results/sub%02d_trial_list.mat',basedir,sub));
    niifile=sprintf('%s/sub%02d/analysis/func_2standard_sub%02d.nii.gz',basedir,sub,sub);
    all_data=load_nii_zip(niifile);
    
    % loop for runs
    for run =1:5
        % normalize along the time dimension (z-scored within scan)
        all_data.img(:,:,:,[1:288]+(run-1)*290)=zscore(all_data.img(:,:,:,[1:288]+(run-1)*290),0,4);
    end
    
    
    onset_ecd=RSA_ss1(:,13);
    onset_maint=RSA_ss1(:,14);
 
    all_data_final_ecd=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),size(RSA_ss1,1));
    all_data_final_maint=zeros(size(all_data.img,1),size(all_data.img,2),size(all_data.img,3),size(RSA_ss1,1));
%     for vol = 1:size(RSA_ss1,1)
%         if onset_ecd(vol)~=0
%             tmp=all_data.img(:,:,:,onset_ecd(vol))+all_data.img(:,:,:,(onset_ecd(vol)+1));
%             % z-scored within each volume (based on Kuhl 2012)
%             idx=tmp~=0;
%             tmp_nonzero=tmp(idx);
%             tmp_nonzero=zscore(tmp_nonzero);
%             tmp(idx)=tmp_nonzero;
%             all_data_final_ecd(:,:,:,vol)=tmp;
%         end
%     end
%     
%     % zscored across all volumes
%     all_data_final_ecd=zscore(all_data_final_ecd,0,4);
%     
%     filename=sprintf('%s/sub%02d/Extracted_ecd_TR_2standard_Sub%02d.nii',basedir,sub,sub);
%     all_data.img=all_data_final_ecd;
%     all_data.hdr.dime.dim(5)=size(RSA_ss1,1); % dimension change according to extracted TR
%     save_untouch_nii(all_data, filename);
    
    
        for vol = 1:size(RSA_ss1,1)
        if onset_maint(vol)~=0
            if onset_maint(vol)~=289
            tmp=all_data.img(:,:,:,onset_maint(vol))+all_data.img(:,:,:,(onset_maint(vol)+1))+all_data.img(:,:,:,(onset_maint(vol)+2));
            else
            tmp=all_data.img(:,:,:,onset_maint(vol))+all_data.img(:,:,:,(onset_maint(vol)+1));
            end
            % z-scored within each volume (based on Kuhl 2012)
            idx=tmp~=0;
            tmp_nonzero=tmp(idx);
            tmp_nonzero=zscore(tmp_nonzero);
            tmp(idx)=tmp_nonzero;
            all_data_final_maint(:,:,:,vol)=tmp;
        end
    end
    
    % zscored across all volumes
    all_data_final_maint=zscore(all_data_final_maint,0,4);
  
    filename=sprintf('%s/sub%02d/Extracted_maint_TR_2standard_Sub%02d.nii',basedir,sub,sub);
    all_data.img=all_data_final_maint;
    all_data.hdr.dime.dim(5)=size(RSA_ss1,1); % dimension change according to extracted TR
    save_untouch_nii(all_data, filename);
%     system(sprintf('gzip -f %s',filename))
    clear all_data all_data_final tmp onset vol filename
    sprintf('Extract TR: Sub%02d is done',sub)
end % sub


end
