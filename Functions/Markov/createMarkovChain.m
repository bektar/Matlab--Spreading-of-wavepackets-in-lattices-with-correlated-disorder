function [markovChain,P] = createMarkovChain(n,N,K,varargin)
%Creates a binary Markov chain with memory length N
%
% Input:
%   n = length of chain
%   N = length of memory
%   K = Correlationfunction
% Optional flags:
%   trashLength = Number of sites to seed and then throw away
%   seed        = An integer to seed the randomized with
%   randomSeed  = Use current time to seed randomizer
%
% Output:
%   markovChain = a binary sequence created using a random number generator
%                 and a memory function. The memory function is created 
%                 using the specified corrolation and is used to set the  
%                 strength of the corrolation between different points in
%                 the chain.
%             P = the conditional probability for each point in the
%                 resulting vector. This is used only for testing.
%
%
% Version 2.2

%% default values for parameters
trashLength = 50*N;

%% handle flags

for ii = 1:2:(nargin-3)
    switch varargin{ii}
        case 'trashLength'
            trashLength = varargin{ii+1};
        case 'seed'
            RandStream.setDefaultStream ...
                (RandStream('mt19937ar','seed',varargin{ii+1}));
        case 'randomSeed'
            RandStream.setDefaultStream ...
                (RandStream('mt19937ar','seed',sum(100*clock)));
        otherwise
            disp('Unknown flag');
    end
end

%% create the Markovchain
Q = n+N+trashLength;
T = zeros(Q,1);

trashChain = createRandomChain(trashLength);
for i = 1:trashLength
	T(i) = trashChain(i);
end

F = calculateMemoryFunction(N,K);
p = zeros(Q,1);

for i = N+1:Q
    p(i) = 1/2;
    for r = 1:N
        p(i) = p(i) + F(r)*(T(i-r)-1/2);
    end

	if (rand<=p(i))
        T(i) = 1;
	else
        T(i) = 0;
	end
end

markovChain = T(Q-n+1:Q);
P           = p(Q-n+1:Q);

end