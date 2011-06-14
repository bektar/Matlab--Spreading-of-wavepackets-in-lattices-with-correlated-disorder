function BTKappa(BatchName,IterationNumber)
%
%   Ställer in vissa värden och kör ett script
%
newPath = genpath('.');
addpath(path,newPath);

RandStream.setDefaultStream ...
	(RandStream('mt19937ar','seed',IterationNumber));

s = sprintf('Starting %s_%03i',BatchName,IterationNumber);
BTLog(['Logs/' BatchName '.log'],s);tic;

load('settings.mat');
eval(BatchName);

s = sprintf('finished %s_%03i after %.2f seconds',BatchName,IterationNumber,toc);
BTLog(['Logs/' BatchName '.log'],s);
end
