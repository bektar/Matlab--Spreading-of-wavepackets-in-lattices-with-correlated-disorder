function K = CF00(r,alpha,beta,zeta)

if (r)
    K = sin(alpha*r)/(beta*r);
else
    K = zeta;
end
end