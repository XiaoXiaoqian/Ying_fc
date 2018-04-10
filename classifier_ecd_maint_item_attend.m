% classifier for action,figure and location

clear,clc

basedir='/seastor/caiying/ActionMemory2_m';

%% add useful functions
addpath /seastor/caiying/toolbox/NIFTI
addpath('/seastor/zhifang/toolbox/classification');
addpath('/seastor/zhifang/toolbox/NIFTI');
addpath('/seastor/zhifang/toolbox/liblinear-1.92/liblinear-1.92/matlab');
addpath('/seastor/zhifang/toolbox/libsvm-3.12/matlab');  


%% subject and roi information%
%subs=[1:3 5:12 14:28]; % all subjects
subs=[1 3 5:12 14:21 23 24 27:28];% capacity in all conditions larger than 1
roi_img_dir=fullfile(basedir,'GroupAnalysis_subs/roi');

cd(roi_img_dir)
roi_names=dir('*ITG.nii.gz');

 typeID=9; %1 for action, 2 for loaction, 3 for figure, 4 for all
 respID=8;% 1 for correct
 AID=10;% action label
 LID=11;% location label
 FID=12;% figure label
    
para=10^0;
option=sprintf('-s 7 -c %10.3f -q', para);

    for s=1:length(subs)
        % read the behavioral label
        all_label=[];
        labelfile=sprintf('%s/behav/results/sub%02d_trial_list.mat',basedir,subs(s));
        load(labelfile);
        all_label=RSA_ss1;
        %all_label(:,8)=ones(length(RSA_ss1),1); % whether include all
        for roi =1:length(roi_names)
            % read the nueral activation
                roi_name=strtok(roi_names(roi).name,'.');
                % train data
                data_train=[]; data_test=[];data_all=[];xx=[];
                x1=load(sprintf('%s/sub%02d/analysis/ROI_based_sub/%s/%s_item_TR04.txt',basedir,subs(s),roi_name,roi_name));
                data_train=x1(4:end,:);% remove the final zero and the first three rows showing the coordinate
                data_train=sparse(data_train);
                
                x2=load(sprintf('%s/sub%02d/analysis/ROI_based_sub/%s/%s_item_TR08.txt',basedir,subs(s),roi_name,roi_name));
                data_test=x2(4:end,:);% remove the final zero and the first three rows showing the coordinate
                data_test=sparse(data_test);
 
                  % attend condition: figure
                  label_train=all_label(all_label(:,respID)==1,AID);
                  label_test_attend=all_label(all_label(:,typeID)==1 & all_label(:,respID)==1,AID);
                  label_test_unattend=all_label(all_label(:,typeID)==2 |all_label(:,typeID)==3 & all_label(:,respID)==1,AID);
                  x_train=data_train(all_label(:,respID)==1,:);
                  x_test_attend=data_test(all_label(:,typeID)==1 & all_label(:,respID)==1,:);
                  x_test_unattend=data_test(all_label(:,typeID)==2|all_label(:,typeID)==3 & all_label(:,respID)==1,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_attend,x_test_attend,model,'-q');
                  acc(s,roi,1,1)=mean(predict_label==label_test_attend);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_unattend,x_test_unattend,model,'-q');
                  acc(s,roi,1,2)=mean(predict_label==label_test_unattend);

                  % attend condition: location
                  label_train=all_label(all_label(:,respID)==1,LID);
                  label_test_attend=all_label(all_label(:,typeID)==2 & all_label(:,respID)==1,LID);
                  label_test_unattend=all_label(all_label(:,typeID)==1 |all_label(:,typeID)==3 & all_label(:,respID)==1,LID);
                  x_train=data_train(all_label(:,respID)==1,:);
                  x_test_attend=data_test(all_label(:,typeID)==2 & all_label(:,respID)==1,:);
                  x_test_unattend=data_test(all_label(:,typeID)==1|all_label(:,typeID)==3 & all_label(:,respID)==1,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_attend,x_test_attend,model,'-q');
                  acc(s,roi,2,1)=mean(predict_label==label_test_attend);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_unattend,x_test_unattend,model,'-q');
                  acc(s,roi,2,2)=mean(predict_label==label_test_unattend);

                  % attend condition: figure
                  label_train=all_label(all_label(:,respID)==1,FID);
                  label_test_attend=all_label(all_label(:,typeID)==3 & all_label(:,respID)==1,FID);
                  label_test_unattend=all_label(all_label(:,typeID)==1 |all_label(:,typeID)==2 & all_label(:,respID)==1,FID);
                  x_train=data_train(all_label(:,respID)==1,:);
                  x_test_attend=data_test(all_label(:,typeID)==3 & all_label(:,respID)==1,:);
                  x_test_unattend=data_test(all_label(:,typeID)==1|all_label(:,typeID)==2 & all_label(:,respID)==1,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_attend,x_test_attend,model,'-q');
                  acc(s,roi,3,1)=mean(predict_label==label_test_attend);
                  [predict_label, accuracy, prob_estimates] = predict(label_test_unattend,x_test_unattend,model,'-q');
                  acc(s,roi,3,2)=mean(predict_label==label_test_unattend);
  end    
        
      
             end

 
    %do the figure for classifier acc
%     for roi =1:length(roi_names)
%         figure
%         fontsize=15;
%         y=squeeze(acc(:,roi,:,:));
%         y=y(:,:);
%         roi_name=strtok(roi_names(roi).name,'.')
%         plot_title=roi_name(:,:);
%         stats=do_anova2(y,2,3,{'attendness','category'});
%         meanmat=squeeze(mean(acc(:,roi,:,:)));
%         meanerr=sqrt(stats{7,4}/size(y,1))*ones(size(meanmat));
%         barerror(meanmat,meanerr,0.9,'k',{'[0.4 0.4 0.4]','[0.65 0.65 0.65]','[0.8 0.8 0.8]'});
%         set(gca,'fontsize',fontsize);
%         set(gca,'xtick',[1:3]);
%         set(gca,'xticklabel',{'Actions','Locations','Figures'});
%         legend('Attend','Unattend');
%         ylabel('Accuracy of Classifiers');
%         title(plot_title);
%         set(gcf,'Color',[1 1 1]) % set background to white
%     end
        %do the figure for classifier acc
    for roi =1:length(roi_names)
        figure
        fontsize=15;
        y=squeeze(acc(:,roi,[1 3],:));
        y=y(:,:);
        roi_name=strtok(roi_names(roi).name,'.')
        plot_title=roi_name(:,:);
        stats=do_anova2(y,2,2,{'attendness','category'});
        meanmat=squeeze(mean(acc(:,roi,[1 3],:)));
        meanerr=sqrt(stats{7,4}/size(y,1))*ones(size(meanmat));
        barerror(meanmat,meanerr,0.9,'k',{'[0.4 0.4 0.4]','[0.8 0.8 0.8]'});
        set(gca,'fontsize',fontsize);
        set(gca,'xtick',[1:3]);
        set(gca,'xticklabel',{'Actions','Figures'});
        legend('Attend','Unattend');
        ylabel('Accuracy of Classifiers');
        title(plot_title);
        set(gcf,'Color',[1 1 1]) % set background to white
    end
    
    
 