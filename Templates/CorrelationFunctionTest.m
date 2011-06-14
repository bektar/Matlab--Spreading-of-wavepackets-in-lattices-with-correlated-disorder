figure(1);
K = @(r) CF00(r,1.8,1.85,1.1);
%K = @CF22;
chain = createMarkovChain(50000,300,K);
[x y] = PrepareCorrelationFigure(chain,'LE');
plot(x,y);
xlim([0 2]);
ylim([0 0.1]);