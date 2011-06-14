function [Time,Psi,Width,Participation] = damwiq(varargin)
%Diffusion of Atomic Matter Waves in one-dimensional Quasi-periodic potentials 
%
% Syntax:
%   [Time,Psi,Width,Participation] = damwiq('flag',variable,...)
%
% Supported flags:
%   alpha       =
%   lambda      =
%   sigma       =
%   theta       =
%   datapoints  =
%   tolerance   =
%   time        =
%   sites       =           om en kedja är given i potential så ignoreras
%                           detta
%   potential   =
%   solver      = [ode45,ode113]
%
% Description:
%
%% default values for parameters
alpha       = (sqrt(5)-2)/2;
lambda      = 2.1;
sigma       = 0.0;
theta       = 0.0;
Q           = 1000;
time        = 100;
tolerance	= 10^-(2+ceil(log10(time)));
sites       = 100;
solver      = @ode45;

%% handle variable in-arguments
for ii = 1:2:nargin
    switch varargin{ii}
        case 'alpha'
            alpha       = varargin{ii+1};
        case 'lambda'
            lambda      = varargin{ii+1};
        case 'sigma'
            sigma       = varargin{ii+1};
        case 'theta'
            theta       = varargin{ii+1};
        case 'datapoints'
            Q           = varargin{ii+1};
        case 'tolerance'
            tolerance   = varargin{ii+1};
        case 'time'
            time        = varargin{ii+1};
            tolerance   = 10^-ceil(2+log10(time));
        case 'timespan'
            timespan    = varargin{ii+1};
            Q           = size(timespan,2);
        case 'sites'
            sites       = varargin{ii+1};
        case 'potential'
            potential   = varargin{ii+1};
        case 'solver'
            solver      = varargin{ii+1};
        otherwise
            disp('Unknown flag, supported flags are: ');
            disp('alpha lambda sigma theta datapoints tolerance time sites potential');
    end
end          

%% initialization
% settings for the diff-solver
options = odeset('RelTol',tolerance,'AbsTol',tolerance);
if (~exist('timespan','var')); timespan = logspace(-2,log10(time),Q); end;

%% runtime
if(exist('potential','var'))
    sites       = max(size(potential));
    WavePacket  = createWavePacket(sites,sigma);
	[Time,Psi]  = solver(@(t,WavePacket)...
                    dPSIdT2(0,WavePacket,sites,lambda,potential),...
                    timespan,WavePacket,options);
else

	WavePacket  = createWavePacket(sites,sigma);
	[Time,Psi]  = solver(@(t,WavePacket)...
                    dPSIdT(0,WavePacket,sites,alpha,lambda,theta),...
                    timespan,WavePacket,options);
end

Width = zeros(Q,1);
for t = 1:Q
	Width(t) = calculateWidth(Psi(t,:));
end
Participation = zeros(Q,1);
for t = 1:Q
    Participation(t) = calculateParticipation(Psi(t,:));
end

%% functions
function dPSI = dPSIdT2(~,psi,n,lambda,chain)
    dPSI = zeros(n,1);
    % main lattice points
    for m = 2:(n-1)
        dPSI(m) = 1i*(-psi(m+1)-psi(m-1)+lambda*chain(m)*psi(m));
    end
end
function dPSI = dPSIdT(~,psi,n,a,lambda,theta)
    dPSI = zeros(n,1);

    % boundry conditions (not really necessary but included for clarity)
    dPSI(1) = 0;
    dPSI(n) = 0;

    % main lattice points
    for m = 2:(n-1)
        j  = m-n/2;
        
        V = lambda*cos(2*pi*a*j+theta);
        
        dPSI(m) = -psi(m+1)-psi(m-1)+V*psi(m);
        dPSI(m) = 1i*dPSI(m);
    end
end
function wavePacket = createWavePacket( n, sigma )
    wavePacket     = zeros(1,n);
    
    switch sigma
        case 0
            if (mod(n,2))
                K = (n+1)/2;
            else
                K =   n  /2;
            end
            wavePacket(K) = 1;
        otherwise
            for m = 1:n
                j=(m-n/2);
                wavePacket(m)=exp(-j^2/(2*sigma^2));
            end
            wavePacket = normalize(wavePacket);
    end
    
    
    function normedPsi = normalize( psi )
    %normalize Returns a vector that is normalized
        dimension = size(psi);

        if (dimension(1)==1)
            fi = psi;
            n = dimension(2);
        else
            fi = psi';
            n = dimension(1);
        end

        x = 0;
        for ij = 1:n
            x = x + abs(fi(ij))*abs(fi(ij));
        end
        N = 1 / sqrt(x);

        normedPsi = fi*N;
    end
end
function P = calculateParticipation( psi )
    n = max(size(psi));
    P = 0;

    for j = 1:n
        P = P + abs(psi(j))^4;
    end

    P = 1 / P;
end
function w = calculateWidth(psi)
    n = size(psi,2);
    w = 0;

    mean = 0;
    for m = 1:n
        j = m-n/2;
        mean = mean+j*abs(psi(m))^2;
    end

    for m = 1:n
        j = m-n/2;
        w = w + (j-mean)^2*abs(psi(m))^2;
    end
    w=sqrt(w);
end
% Returns a Gaussian wave packet for a given lattice size
end