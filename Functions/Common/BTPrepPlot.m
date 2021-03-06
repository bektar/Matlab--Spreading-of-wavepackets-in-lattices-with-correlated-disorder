function [X Y] = BTPrepPlot(BatchName,variable,varargin)
%
% Syntax:
%	[X Y] = BTPrepPlot(BatchName,variable)
%   [X Y] = BTPrepPlot(BatchName,variable,iteration)
%   [X Y] = BTPrepPlot(BatchName,wave,iteration,time)
%   [X Y] = BTPrepPlot(BatchName,'correlation',....)
%   [X Y] = BTPrepPlot(CorrelationFunction,type,...)
%   [X Y] = BTPrepPlot(CorrelationFunction,NumberOfIterations,iteration)
%
%   variables
%       mean, max, min
%       iteration
%       NLk,NLE,Lk,LE
%       lambda
%       time
%

    function [ Norm ] = PrepareNorm( BatchName )
        %UNTITLED4 Summary of this function goes here
        %   Detailed explanation goes here
        
        function norm = calculateNorm(wave)
            norm = 0;
            for m = 1:size(wave,2)
                norm = norm + abs(wave(m)).*abs(wave(m));
            end
        end
        
        s = sprintf('Library/Results/%s',BatchName); Batch = load(s);
        s = sprintf('Batch = Batch.%s;', BatchName); eval(s);
        
        BatchSize = size(Batch,2);
        
        Time = size(Batch(1).Time,1);
        Norm = zeros(Time,BatchSize);
        for ij = 1:BatchSize
            s = sprintf('Library/Results/Wave Data/%s Wave%02d',...
                BatchName,ij); Wave = load(s);
            s = sprintf('Wave = Wave.%s_Wave%02d;',BatchName,ij); eval(s);
            
            for t = 1:Time
                Norm(t,ij) = calculateNorm(Wave(t,:));
            end
        end
    end

s = sprintf('Library/Results/%s',BatchName); structure = load(s);
s = sprintf('structure = structure.%s;',BatchName); eval(s);

IterationToDisplay = 'mean';
type = 'LE';
horizontal_start = 0;
horizontal_ending = 2;
NumberOfIterations = size(structure,2);
NumberOfDataPoints = size(structure(1).Time,1);

%% Handle input
for ii = 1:(nargin-2)
    switch varargin{ii}
        case 'mean'
            IterationToDisplay = 'mean';
        case 'max'
            IterationToDisplay = 'max';
        case 'min'
            IterationToDisplay = 'min';
        case 'iteration'
            IterationToDisplay = varargin{ii+1};
        case 'NLk'
            type = 'NLk';
            horizontal_start = 0;
            horizontal_ending = pi;
        case 'NLE'
            type = 'NLE';
            horizontal_start = 0;
            horizontal_ending = 2;
        case 'Lk'
            type = 'Lk';
            horizontal_start = 0;
            horizontal_ending = pi;
        case 'LE'
            type = 'LE';
            horizontal_start = 0;
            horizontal_ending = pi;
        case 'lambda'
            lambda = varargin{ii+1};
        case 'time'
            Time = varargin{ii+1};
    end
end

switch variable
    case 'participation'
        
        data = zeros(size(structure(1).Participation,1),NumberOfIterations);
        for ii = 1:NumberOfIterations
            data(:,ii) = structure(ii).Participation;
        end
        X = structure.Time;

    case 'width'
        
        data = zeros(size(structure(1).Width,1),NumberOfIterations);
        for ii = 1:NumberOfIterations
            data(:,ii) = structure(ii).Width;
        end
        X = structure.Time;
        
    case 'norm'
        
        data = PrepareNorm(BatchName);
        X = structure.Time;

    case 'wave'
        
        s = sprintf('Library/Results/Wave Data/%s Wave01',...
            BatchName); wave = load(s);
        s = sprintf('wave = wave.%s_Wave01(Time,:);',...
            BatchName); eval(s);
        NumberOfSites = size(wave,2);
        
        data = zeros(NumberOfSites,NumberOfIterations);
        for ii = 1:NumberOfIterations
            s = sprintf('Library/Results/Wave Data/%s Wave%02d',...
                BatchName,ii); wave = load(s);
            s = sprintf('wave = wave.%s_Wave%02d(Time,:);',...
                BatchName,ii); eval(s);
            data(:,ii) = abs(wave).*abs(wave);
        end
        X = 1:NumberOfSites;
    case 'correlation'
        data = zeros(NumberOfDataPoints,NumberOfIterations);
        for ii = 1:NumberOfIterations
            tmp = structure(ii).Potential;
            [X data(:,ii)] = PrepareCorrelationFigure(tmp,type,'lambda',lambda,'start',horizontal_start,'ending',horizontal_ending);
        end
end

%%
switch IterationToDisplay
    case 'mean'
        Y = mean(data,2);
    case 'max'
        Y = max(data,[],2);
    case 'min'
        Y = min(data,[],2);
    otherwise
        Y = data(:,IterationToDisplay);
end
end