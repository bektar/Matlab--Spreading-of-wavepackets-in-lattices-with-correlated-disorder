
BatchName = 'd236';


timespan = logspace(-2,5,1000);

times = [1 100 200 300 400 500 600 625 650 675 700 750 760:790 800 850 900 1000];

s = sprintf('~/Documents/Matlab/Graphs/Waves/%s',BatchName);
if(exist(s,'dir')~=7); mkdir(s); end;

for ii = 1:size(times,2)
    h = figure(1);
    [dwave dwavex] = BTPrepPlot(BatchName,'wave','time',times(ii));
    
    plot(dwavex,dwave);
    
    s = sprintf('%s - Spike',BatchName);
    title(s);
    
    s = sprintf('Iteration = %i, Time = %f',times(ii),timespan(times(ii)));
    suptitle(s);
    
    s = sprintf('Graphs/Waves/%s/T=%f.fig',BatchName,timespan(times(ii)));
    saveas(h,s,'fig');
    close(h);
end
