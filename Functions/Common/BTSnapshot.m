function BTSnapshot(s)

BTLog('~/Documents/Matlab/Library/Snapshots/Index of Snapshots.txt',s);

snapshot = ['~/Documents/Matlab/Library/Snapshots/'...
                datestr(now,'yyyy-mm-dd HH.MM.SS') '/'];

mkdir([snapshot '/Functions/']);
mkdir([snapshot '/Scripts/']);
mkdir([snapshot '/Templates/']);

copyfile('~/Documents/Matlab/Functions',[snapshot '/Functions/']);
copyfile('~/Documents/Matlab/Scripts',[snapshot '/Scripts/']);
copyfile('~/Documents/Matlab/Templates',[snapshot '/Templates/']);
end