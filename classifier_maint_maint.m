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
roi_names=dir('*TOF.nii.gz');

 typeID=9; %1 for action, 2 for loaction, 3 for figure, 4 for all
 runID=2;% run num
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
        for roi =1:length(roi_names)
            % read the nueral activation
             for roi=1:length(roi_names);
                roi_name=strtok(roi_names(roi).name,'.');
                data_all=[];xx=[];
                data_all=load(sprintf('%s/sub%02d/analysis/ROI_based_sub/%s/%s_item_maint.txt',basedir,subs(s),roi_name,roi_name));
                x_all=data_all(4:end,:);% remove the final zero and the first three rows showing the coordinate
                x_all=sparse(x_all);
            % do leave-one out classifer
              if subs(s)==5
                  run_num=4;
              else
                  run_num=5;
              end
             
              % classifier for action & figure
           
              for run_test=1:run_num
                  % Label
                  label_train=all_label((all_label(:,runID)~=run_test & all_label(:,typeID)==1) | (all_label(:,runID)~=run_test & all_label(:,typeID)==3),typeID );
                  label_test=all_label((all_label(:,runID)==run_test & all_label(:,typeID)==1) | (all_label(:,runID)==run_test & all_label(:,typeID)==3),typeID);
                  x_train=x_all((all_label(:,runID)~=run_test & all_label(:,typeID)==1) | (all_label(:,runID)~=run_test & all_label(:,typeID)==3) ,:);
                  x_test=x_all((all_label(:,runID)==run_test & all_label(:,typeID)==1) | (all_label(:,runID)==run_test & all_label(:,typeID)==3) ,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test,x_test,model,'-q');
                  acc(s,roi,1,run_test)=mean(predict_label==label_test);
              end
              
              %classifier for location & figure
              for run_test=1:run_num
                  % Label
                  label_train=all_label((all_label(:,runID)~=run_test & all_label(:,typeID)==2) | (all_label(:,runID)~=run_test & all_label(:,typeID)==3),typeID );
                  label_test=all_label((all_label(:,runID)==run_test & all_label(:,typeID)==2) | (all_label(:,runID)==run_test & all_label(:,typeID)==3),typeID);
                  x_train=x_all((all_label(:,runID)~=run_test & all_label(:,typeID)==2) | (all_label(:,runID)~=run_test & all_label(:,typeID)==3) ,:);
                  x_test=x_all((all_label(:,runID)==run_test & all_label(:,typeID)==2) | (all_label(:,runID)==run_test & all_label(:,typeID)==3) ,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test,x_test,model,'-q');
                  acc(s,roi,2,run_test)=mean(predict_label==label_test);
              end
              
              %classifier for action and location 
              for run_test=1:run_num
                  % Label
                  label_train=all_label((all_label(:,runID)~=run_test & all_label(:,typeID)==1) | (all_label(:,runID)~=run_test & all_label(:,typeID)==2),typeID );
                  label_test=all_label((all_label(:,runID)==run_test & all_label(:,typeID)==1) | (all_label(:,runID)==run_test & all_label(:,typeID)==2),typeID);
                  x_train=x_all((all_label(:,runID)~=run_test & all_label(:,typeID)==1) | (all_label(:,runID)~=run_test & all_label(:,typeID)==2) ,:);
                  x_test=x_all((all_label(:,runID)==run_test & all_label(:,typeID)==1) | (all_label(:,runID)==run_test & all_label(:,typeID)==2) ,:);
                  % do classification
                  model=train(label_train, x_train, option);
                  [predict_label, accuracy, prob_estimates] = predict(label_test,x_test,model,'-q');
                  acc(s,roi,3,run_test)=mean(predict_label==label_test);
              end
             
             end
        end
    end
    
        
    %do the figure for classifier acc
    for roi =1:length(roi_names)
        
        y=[mean(acc([1 2 4:end],roi,:,:),4);mean(acc(3,roi,:,[1:4]),4)];
        y=squeeze(y)
         roi_name=strtok(roi_names(roi).name,'.')
         plot_title=roi_name(:,:);
        [stats f p]=do_anova1(y);
        withsub_err=sqrt(stats/size(y,1));
        meanmat=mean(y)'
        stdmat=withsub_err*ones(size(meanmat));
        stats_sum(roi,1)=p;
        
        y_acc(:,roi,:)=y;
        
        acc_fa=y(:,1);
        acc_fl=y(:,2);
        acc_al=y(:,3);
         [H,P,CI,STATS]=ttest(acc_fa,0.5);
          stats_sum(roi,2)=P;
         [H,P,CI,STATS]=ttest(acc_fl,0.5);
          stats_sum(roi,3)=P;
         [H,P,CI,STATS]=ttest(acc_al,0.5);
          stats_sum(roi,4)=P;
        
        figure
        condnames={'F_A','F_L','A_L'};
        plot_title=roi_name(:,:);
        sizes=15;
        hold on
        barerror(meanmat,stdmat,0.9,'k',{'g','r','b'})
        set(gca,'XTick',[1:3])
        set(gca,'Xticklabel',condnames);
        set(gca,'FontSize',sizes)
        set(gca,'fontname','Arial')
        set(gcf,'Color',[1 1 1]) % set background to white
        ylabel('Classifier Acc')
        title(plot_title)
        hold off
        orient tall
        
    end
    
    %prepare for the figures
    
% figure;
% fontsize=20;
% y_acc=y_acc(:,[4 1 3 2],:);
% %y_acc=y_acc(:,[1 2 4],:)
% y=y_acc(:,:);
% stats=do_anova2(y,3,4,{'classifiers','rois'});
% meanmat=squeeze(mean(y_acc));
% meanerr=sqrt(stats{7,4}/size(y,1))*ones(size(meanmat));
% barerror(meanmat,meanerr,0.9,'k',{'[0.4 0.4 0.4]','[0.65 0.65 0.65]','[0.8 0.8 0.8]'});
% set(gca,'fontsize',fontsize);
% set(gca,'xtick',[1:4]);
% set(gca,'xticklabel','LMT|SPL|LMFG|LFP');
% legend('F-A','F-L','A-L');
% ylabel('Accuracy of Classifiers');
%         