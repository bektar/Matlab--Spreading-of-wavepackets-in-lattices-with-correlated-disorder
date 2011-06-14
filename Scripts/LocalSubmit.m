%% Preparation
load('settings.mat'); delete('settings.mat');

movefile('.','~/Documents/Matlab/Library/Jobs/running/');
cd(['~/Documents/Matlab/Library/Jobs/running/' BatchName]);

initialPath = path;
restoredefaultpath;
newPath = genpath('.');
addpath(path,newPath);

s = sprintf('%s starting up...',BatchName);
BTLog(logfile,s);
totaltime = tic;

IterationNumber = 1;
% run the batch script
eval(BatchName);

%% Completion
totaltime = toc(totaltime);
s = sprintf('%s finished after %.2f seconds',BatchName,totaltime);
BTLog(logfile,s);

path(initialPath);

movefile('.','~/Documents/Matlab/Library/Jobs/finished/');
