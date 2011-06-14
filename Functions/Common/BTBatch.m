function BTBatch(script,worktype,worker,varargin)
%
%
%   atm måste script vara fullständig path
%
%
%
%
%   Version 2.0b3

%% Default settings
BTBatch_LOGFILE    = '~/Documents/Matlab/Library/logs/BTBatch.log';
BatchDescription   = ' ';
NumberOfIterations = 8;
NumberOfNodes      = 1;
TimeLimit          = '02:00:00';

%% Handle input
% Make sure the script exist.
% Atm script must contain full path, needs to be corrected... !ATTENTION!
if (exist(script,'file') == 2)
    SCRIPT_TO_RUN = script;
else
    s = sprintf('%s is not a valid .m file',script);
    exception = MException('BTBatch:SCRIPT_TO_RUN',s);
    throw(exception);
end

for ii = 1:2:max(size(varargin))
    switch varargin{ii}
        case 'NumberOfIterations'
            NumberOfIterations = varargin{ii+1};
        case 'NumberOfNodes'
            NumberOfNodes = varargin{ii+1};
        case 'TimeLimit'
            TimeLimit = varargin{ii+1};
        case 'Description'
            BatchDescription = varargin{ii+1};
        otherwise
            s = sprintf('%s is an unsupported flag',varargin{ii});
            exception = MException('BTBatch:varargin',s);
            throw(exception);
    end
end

% Determine what kind of job and serialnumber. 
% Store this information in BatchName
switch worktype                     
    case 'damwiq'       
        s = '~/Documents/Matlab/Library/SerialNumbers/dBatchSerialNumber.mat';
        if(exist(s,'file') == 2)
            load(s);
            BatchSerialNumber = BatchSerialNumber + 1; %#ok<NODEF>
        else
            BatchSerialNumber = 1;
        end
        
        BatchName = sprintf('d%03d',BatchSerialNumber);
        save(s,'BatchSerialNumber');
        
    otherwise           
        s = sprintf('%s is an unsupported worktype',worktype);
        exception = MException('BTBatch:worktype',s);
        throw(exception);
end

%% Configure directories
  matlab_dir  = '~/Documents/Matlab/';
 pending_dir  = [matlab_dir 'Library/Jobs/pending/'  BatchName '/'];

if(exist([pending_dir 'Logs'],'dir')~=7); mkdir([pending_dir 'Logs']); end;
if(exist([pending_dir 'Results'],'dir')~=7); mkdir([pending_dir 'Results']); end;

copyfile([matlab_dir 'Functions/'],[pending_dir '/Functions/']);
copyfile([matlab_dir 'Scripts/']  ,[pending_dir '/Scripts/']);

%% 
logfile = ['Logs/' BatchName '.log'];
save([pending_dir 'settings.mat'],'BatchSerialNumber','BatchName','logfile');
copyfile(SCRIPT_TO_RUN,[pending_dir BatchName '.m']);

s = sprintf('%s created by BTBatch',BatchName);
BTLog([pending_dir logfile],s);
BTLog('~/Documents/Matlab/Library/Jobs/Index of Jobs.txt',...
       [BatchName ' - ' BatchDescription]);

%%
switch worker
    case 'local'                        
        batch('LocalSubmit','CurrentDirectory',pending_dir,...
            'matlabpool',0);
        
        s = sprintf('%s put in que.',BatchName);
        BTLog([pending_dir logfile],s);

    case 'atlantis'
        % logga tidpunkt filen är hanterad
        s = sprintf('%s starting to copy to !NOT IMPLEMETED',BatchName);
        BTLog([pending_dir logfile],s);
        
        % kopiera jobbmappen till kappa
        s = sprintf('!scp -r %s atlantis.ronnbacks.se:%s>>%s',...
            pending_dir,'~/Desktop/',BTBatch_LOGFILE);
        eval(s);
         
        % kolla om screen sessionen för matlab är igång
            % om den är det logga in och lägg till i kön
            % om den inte är det starta och lägg till i kön
    case 'kappa'
        % logga tidpunkt filen är hanterad
        s = sprintf('%s starting to copy to kappa',BatchName);
        BTLog([pending_dir logfile],s);
        
        copyfile([matlab_dir 'Functions/Common/BTKappa.m'],pending_dir);        % temporär lösning.....
                
        KappaSubmitScript = fopen([pending_dir ...                              % RIKTIGT ful lösning :)
            'Scripts/ParallelSubmit.sh'],'r+');
        fprintf(KappaSubmitScript,...
                ['#!/bin/bash\n'...
                'BatchName=%s\n'...
                'NumberOfIterations=%i\n'],...
                 BatchName,NumberOfIterations);
        fclose(KappaSubmitScript); 
        
        % kopiera jobbmappen till kappa
        s = sprintf('!scp -r %s x_jakro@kappa.nsc.liu.se:%s>>%s',...
            pending_dir,'~/jobs/',BTBatch_LOGFILE);
        eval(s);

        % lägg till i kö
        s = sprintf(['!ssh x_jakro@kappa.nsc.liu.se '...
                     '"module add matlab;cd jobs/%s;'...
                     'sbatch -N %s -t %s -J %s Scripts/ParallelSubmit.sh"'],...
                        BatchName,int2str(NumberOfNodes),TimeLimit,BatchName);
        eval(s);
        
        rmdir(pending_dir,'s');
    otherwise
        s = sprintf('%s is an unsupported worker',worker);
        exception = MException('BTBatch:Worker',s);
        throw(exception);
        
end

s = sprintf('%s handled successfully by BTBatch',BatchName);
disp(s);
end
