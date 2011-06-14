function [ K ] = cfalternating( r )

C = (-1)^r/4;
C0 = 1/4;
K = C / (C0);

end

% C(0) = 1/4 enligt Kroon mellan eq 2.26 och eq 2.27