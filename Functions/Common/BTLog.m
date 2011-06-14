function BTLog( filename, message )
%Quick and dirty function to log messages
%
%   Syntax:
%       file    = string containing the filename
%       message = the message that should be logged
%
%   Description:
%       Function to make it easy to log events with a timestamp.
%

switch filename
    case 'error'
        fileID = fopen('~/Documents/Matlab/Library/Errors.txt','a');
    otherwise
        fileID = fopen(filename,'a');
end

fprintf(fileID,'%s - %s\n',datestr(now),message);
fclose(fileID);
end

