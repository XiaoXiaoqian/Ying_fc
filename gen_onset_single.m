%data structure in sv learning
Mtrial=1; % trial number
MID=2;  % material id
Mcons=3; %1:CONSISTENT, INCONSISTENT;0: filler
Msem1=4; % semantic category for live;  1,nonliving; 2,living
Msem2=5; % semantic category for size;  1,bigger; 2,smaller
Mtask=6; % task;3=living/noliving;4=bigger/smaller
Mcorr=7; % correct response for this trial, left vs. right. 1 or 2;
Mres=8; % left or right key. left: living; right: nonliving;
Mscore=9; % 1: correct; 0 wrong;
MRT=10; % reaction time;
Monset=11; % designed onset time
MAonset=12; % actually onset time
%added information
Mmem=13;

%preparation
basedir='/seastor/helenhelen/method_psa';
subs=[11:14];
dur=2;
behavdir=sprintf('%s/behav',basedir);
cd(behavdir)

for sub=subs
   file=dir(sprintf('memtest_sub%02d_*.mat',sub));
   load(file.name);
   MT=sortrows(SM,2);

   % now define 3 category
   perf1(MT(:,4)<=4)=2;%forgot
   perf1(MT(:,4)>=6)=1;%rem
   perf1(MT(:,4)==5)=3;%filler

  for run_no=1:3
    file=dir(sprintf('sv_sub%02d_run%d_*.mat',sub,run_no));
    load(file.name);

    trial=unique(SM(:,2));
    SM=sortrows(SM,2); %% sort according to trial number;
    perf=perf1(trial); % get memory performance

    SM(1:2:end,Mmem)=perf;
    SM(2:2:end,Mmem)=perf;
    SM=sortrows(SM,MAonset); %% sort according to onset;
    tmp1=SM(:,MAonset); %% onset;
    tmp2=[tmp1,ones(size(tmp1))*dur ones(size(tmp1))];
    outputfile=sprintf('%s/sub%02d/behav/run%d_all.txt',basedir,sub,run_no);
    eval(sprintf('save %s tmp2 -tabs -ascii',outputfile));

    trial_list_all=SM(:,[MID Mmem MAonset Mcons]); 
    label={'material_ID';'memory';'onset';'cons_incons'};
    eval(sprintf('save %s/behav/label/sub%02d_run%d_singletriallist trial_list_all label',basedir,sub,run_no));


     %% error trial
     tmp1=grate(grate(:,3)<0,5); %% get all the wrong trials
     tmp2=[tmp1,ones(size(tmp1))*0.5 ones(size(tmp1))];
     outputfile=sprintf('%s/sub%02d/behav/run%d_err.txt',basedir,sub,run_no);
     eval(sprintf('save %s tmp2 -tabs -ascii',outputfile));
    end% run/*
end % sub
