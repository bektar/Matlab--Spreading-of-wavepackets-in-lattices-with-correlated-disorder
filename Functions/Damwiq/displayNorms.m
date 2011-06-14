function Norms = displayNorms( Psi, Time )
%displayNorms Calculates the norm for each psi and plots this vs time

% Create vector with calculated normal for each datapoint
Norms = zeros(max(size(Time)),1);
for t = 1:size(Time,1)
    Norms(t) = calculateNorm(Psi(t,:));
end

%% Functions
function Norm = calculateNorm( psi )
%calculateNorm Sums the square of the absolute value of each element
%   Detailed explanation goes here
Norm = 0;

dimension = size(psi);
if (dimension(1)==1)
    psi = psi';
    n = dimension(2);
else 
    n = dimension(1);
end

for m = 1:n
    Norm = Norm + abs(psi(m)).*abs(psi(m));
end

end
% Sums the square of the absolute value of each element
end