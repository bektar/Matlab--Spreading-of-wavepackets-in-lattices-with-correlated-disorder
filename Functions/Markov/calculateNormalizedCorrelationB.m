function [ K ] = calculateNormalizedCorrelationB(chain,r)
%% periodisk shiftfunktion
N = max(size(chain));

A = chain;
B = shiftChainB(chain,r);

C   = sum(A.*B) / N - (mean(A))^2;
C0  = sum(A.*A) / N	- (mean(A))^2;

if(C0)
    K   = C / C0;
else
    K   = C / (1/4);
end
%%
function [ shifted ] = shiftChainB( chain, r )
%Shifts a vector a number of steps

N = max(size(chain));
shifted = zeros(N,1);

if (r>N); r = mod(r,N); end;

for n = 1:N-r
    shifted(n) = chain(n+r);
end

for n = 1:r
    shifted(n+N-r) = chain(n);
end

end
end