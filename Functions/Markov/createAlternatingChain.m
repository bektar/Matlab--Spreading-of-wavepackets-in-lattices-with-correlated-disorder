function [ chain ] = createAlternatingChain( n )
    chain = zeros(n,1);
    for rr = 1:2:n; chain(rr) = 1; end
end