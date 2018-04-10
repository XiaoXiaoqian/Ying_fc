row=1;
for n =1:190
    for m=[1:n-1,n+1:3]
        a=sprintf('set fmri(conmask%d_%d) 0',n,m);
        xlswrite('Ftest.xlsx',{a},1,['A',num2str(row)]);
        row = row +1;
        %set2((n-1)*10+m,:)=a;
    end
end