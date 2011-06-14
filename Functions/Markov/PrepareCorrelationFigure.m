function [X Y] = PrepareCorrelationFigure(C,type,varargin)
% Prepares X and Y values for a figure from a correlation function
%
% Syntax:
%   [X Y] = PrepareCorrelationFigure(C,type,...)
%
% Required input:
%   C       = either a chain of ones and zeros or a
%             function handle to a correlation function
%   type    = 'NLk' - Normalized Lyapunov exponent vs k
%             'NLE' - Normalized Lyapunov exponent vs E
%             'Lk'  - Lyapunov exponent vs k L
%             'LE'  - Lyapunov exponent vs E
%
% Supported flags:                                           defaults
%   start                   = starting value for X-axis      k=-pi, E=0
%   ending                  = ending value for X-axis        k= 0 , E=2
%   NumberOfDataPoints      = number of points to store      1000
%   StepsInFourierTransform = number of steps in transform   300
%   lambda                  = strength of disorder           1.0 (strong)
%
%   Description:
%
%% default values for parameters

NumberOfDataPoints      = 1000;
StepsInFourierTransform = 300;
%% handla flags and input
switch type
    case 'NLk'
        start = -pi;
        ending   = 0;
    case 'NLE'
        start = 0;
        ending   = 2;
    case 'Lk'
        start = -pi;
        ending   = 0;
        lambda = 1;
    case 'LE'
        start = 0;
        ending   = 2;
        lambda = 1;
    otherwise
        s = sprintf('%s is an unsupported type',type);
        exception = MException('BTBatch:flags',s);
        throw(exception);
end

for ii = 1:2:(max(size(varargin)))
    switch varargin{ii}
        case 'start'
            start = varargin{ii+1};
        case 'ending'
            ending   = varargin{ii+1};
        case 'NumberOfDataPoints'
            NumberOfDataPoints      = varargin{ii+1};
        case 'StepsInFourierTransform'
            StepsInFourierTransform = varargin{ii+1};
        case 'lambda'
            lambda      = varargin{ii+1};
        otherwise
            s = sprintf('%s is an unsupported flag. ii =%i',varargin{ii},ii);
            disp(s);
    end
end

%% figure out if a chain or a function was supplied
K = zeros(StepsInFourierTransform,1);
if(isa(C,'function_handle'))
    parfor r = 1:StepsInFourierTransform
        K(r) = feval(C,r);
    end
elseif(isa(C,'numeric'))
    parfor r = 1:StepsInFourierTransform
        K(r) = calculateNormalizedCorrelationB(C,r);
    end
else
    disp('C is neither a chain nor a correlationfunction.');
end

%% perform fouriertransform
step  = (ending - start)/NumberOfDataPoints;
X = start:step:ending-step;

switch type
    case 'NLk'
        
        parfor q = 1:NumberOfDataPoints
            k = X(q);
            
            transformElements = zeros(StepsInFourierTransform,1);
            for r = 1:StepsInFourierTransform
                transformElements(r) = K(r) * cos(k*r);
            end
            Y(q) = 1 + 2 * sum(transformElements);
        end
    case 'NLE'
        parfor q = 1:NumberOfDataPoints
            k = acos(-X(q)/2);
            
            transformElements = zeros(StepsInFourierTransform,1);
            for r = 1:StepsInFourierTransform
                transformElements(r) = K(r) * cos(2*k*r);
            end
            Y(q) = 1 + 2 * sum(transformElements);
        end
    case 'Lk'
        parfor q = 1:NumberOfDataPoints
            k = X(q);
            
            transformElements = zeros(StepsInFourierTransform,1);
            for r = 1:StepsInFourierTransform
                transformElements(r) = K(r) * cos(k*r);
            end
            Y(q) = lambda^2/(32*sin(k)^2)*(1 + 2 * sum(transformElements));
        end
    case 'LE'
        parfor q = 1:NumberOfDataPoints
            k = acos(-X(q)/2);
            
            transformElements = zeros(StepsInFourierTransform,1);
            for r = 1:StepsInFourierTransform
                transformElements(r) = K(r) * cos(2*k*r);
            end
            Y(q) = lambda^2/(32*sin(k)^2)*(1 + 2 * sum(transformElements));
        end
end

end