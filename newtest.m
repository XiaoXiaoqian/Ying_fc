f = fopen('Ftest.txt', 'w');
for n = 1:190
    for m = 1:190
        if m ~= n 
            fprintf(f, 'set fmri(conmask%d_%d) 0\r\n', n, m);
        end
    end
end
fclose(f);