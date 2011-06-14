function [F,Kmatrix,Kvector] = calculateMemoryFunction( N, K )

Kmatrix = zeros(N);
for r = 1:N
    for rp = 1:N
        Kmatrix(r,rp) = K(r-rp);
    end
end

Kvector = zeros(N,1);
for r = 1:N
    Kvector(r) = K(r);
end

F = Kmatrix\Kvector;
end