function run_single_ER(sub,r)
addpath /seastor/caiying/toolbox/NIFTI
addpath /opt/fmritools/spm/spm5
addpath /seastor/caiying/ActionMemory2_m/script

basedir='/seastor/caiying/ActionMemory2_m';
featdir=sprintf('%s/sub%02d/analysis/run%d_singletrial.feat',basedir,sub,r)
single_event_model_ls2(featdir);
