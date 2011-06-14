Potential = createMarkovChain(32e3,300,@CF17);

[Time Wave Width Participation] = ...
    damwiq('lambda',0.2,'time',2e4,'potential',Potential,...
    'tolerance',1e-7,'solver',@ode113);

s = sprintf('Results/%s_%02i Results.mat',BatchName,IterationNumber);
save(s,'Time', 'Wave', 'Width', 'Participation','Potential');
