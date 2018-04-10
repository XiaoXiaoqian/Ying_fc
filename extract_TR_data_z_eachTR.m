    function extract_TR_data_z_eachTR(sub,run)
    %extract testing and localizer task timepoint
    %clear,clc

    basedir='/seastor/caiying/ActionMemory2_m';

    addpath /seastor/caiying/toolbox/NIFTI


    %% loop for subs
       %load data
        load(sprintf('%s/behav/results/sub%02d_trial_list.mat',basedir,sub));
        niifile=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/filtered_func_data_2standard.nii.gz',basedir,sub,run);
        all_data=load_nii_zip(niifile);
        % normalize along the time dimension (z-scored within scan)
        all_data.img(:,:,:,:)=zscore(all_data.img(:,:,:,:),0,4);  
        onset_ecd=RSA_ss1(RSA_ss1(:,2)==run,13); %the 5thTR after the onsettime
        onset_tr=onset_ecd-4;% the onset TR
        %end
     all_data_all=all_data.img;
     all_data_final_TR=zeros(size(all_data_all,1),size(all_data_all,2),size(all_data_all,3),12);

       for time=1:8 % 14 tr
        for vol = 1:12 % 12 trials for each run
            if onset_tr(vol)~=0 
               trs=onset_tr(vol)+time-1;

                 tmp=all_data_all(:,:,:,onset_tr(vol)+time-1);
                         % z-scored within each volume (based on Kuhl 2012)
                 idx=tmp~=0;
                 tmp_nonzero=tmp(idx);
                 tmp_nonzero=zscore(tmp_nonzero);
                 tmp(idx)=tmp_nonzero;
                 all_data_final_TR(:,:,:,vol)=tmp;
            end
        end
        % zscored across all volumes
        all_data_final_TR=zscore(all_data_final_TR,0,4);
        filename=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/Extracted_z_2standard_TR%02d.nii',basedir,sub,run,time);
        all_data.img=all_data_final_TR;
        all_data.hdr.dime.dim(5)=12; % dimension change according to extracted TR
        save_untouch_nii(all_data, filename);
        clear all_data_final_TR tmp tmp_nonzero vol
       end

       for time=9:14 % 14 tr
        for vol = 1:11 % 11 trials for each run the last one 
            if onset_tr(vol)~=0 
                 tmp=all_data_all(:,:,:,onset_tr(vol)+time-1);
                 % z-scored within each volume (based on Kuhl 2012)
                 idx=tmp~=0;
                 tmp_nonzero=tmp(idx);
                 tmp_nonzero=zscore(tmp_nonzero);
                 tmp(idx)=tmp_nonzero;
                 all_data_final_TR(:,:,:,vol)=tmp;
            end
        end
        % zscored across all volumes
        all_data_final_TR=zscore(all_data_final_TR,0,4);
        all_data_final_TR(:,:,:,12)=zeros(size(all_data_all,1),size(all_data_all,2),size(all_data_all,3));
        filename=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat/Extracted_z_2standard_TR%02d.nii',basedir,sub,run,time);
        all_data.img=all_data_final_TR;
        all_data.hdr.dime.dim(5)=12; % dimension change according to extracted TR
        save_untouch_nii(all_data, filename);
        clear all_data_final_TR tmp tmp_nonzero vol
        end

        sprintf('Extract TR: Sub%02d run%02d is done',sub, run)
        clear all
        end % sub

