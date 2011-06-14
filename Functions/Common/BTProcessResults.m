function BTProcessResults(BatchName)

RELATIVE_PATH = sprintf('Library/Jobs/finished/%s/Results/',BatchName);

BatchSize = length(dir(RELATIVE_PATH))-2;
    
for jj = 1:BatchSize
    s1 = sprintf('%s_%02i Results.mat',BatchName,jj);
    s3 = sprintf('load(''%s%s'');',RELATIVE_PATH,s1);
    eval(s3);
    
    I = struct('Participation',Participation,'Potential',Potential,...
               'Time',Time,'Width',Width);
    StructArray(jj) = I;
    
    s = sprintf('%s_Wave%02d = Wave;',BatchName,jj); eval(s);

    s = sprintf(['save(''Library/Results/Wave Data/',...
                 '%s Wave%02d'',''%s_Wave%02d'')'],...
                  BatchName,jj,BatchName,jj); eval(s);
    s = sprintf('clear %s_Wave%02d',BatchName,jj); eval(s);
    
end
s = sprintf('%s = StructArray;',BatchName); eval(s);
s = sprintf('save(''Library/Results/%s'',''%s'');',BatchName,BatchName); eval(s);



end