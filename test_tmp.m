cd ../sub01/analysis/ROI_based/aSPL_new2
clear,clc
load 'aSPL_new2_maint_raw.txt'
plot(aSPL_new2_item_maint_raw(:,1:2))
all_data=aSPL_new2_item_maint_raw(4:end,1:end);
cc=1-pdist(all_data(:,:),'correlation');

     figure
     A=squareform(cc);
     A(logical(eye(size(A))))=1;
     imagesc(A);colorbar;
  