function displayPsi(Psi,t)
%displayPsi Plots a  probability distribution psi at time t
%   Detailed explanation goes here
psi = Psi(t,:);
plot(abs(psi).*abs(psi));

end

