function [ chain ] = createRandomChain( n )
    chain = zeros(n,1);
    parfor rr = 1:n; chain(rr) = round(rand); end
end