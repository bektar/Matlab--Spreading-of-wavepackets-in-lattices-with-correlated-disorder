function BTSave(filename,object,variable) %#ok<INUSL>
%Saves data in <object> as <variable> in file <filename>
%
%   Syntax:
%       filename = string containing filename to save data in
%       object   = the data to be saved
%       variable = string containing name of the variable to store data in
%
%   Description:
%       This function was created to allow saving data from parfor-loops. 
%       It also alowes the variable name to be specified.
%

string = sprintf('%s = object;',variable);

eval(string);

save(filename,variable);

end