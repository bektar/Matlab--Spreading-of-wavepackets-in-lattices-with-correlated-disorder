[y2 x2] = BTPrepPlot('d203','width'); %CF17
[y3 x3] = BTPrepPlot('d204','width'); %CF21
[y4 x4] = BTPrepPlot('d205','width'); %CF22

loglog(x2,y2,x3,y3,x4,y4);

%% CF17 Gaussian
X = logspace(-2,5,1000);

[y2 x2] = BTPrepPlot('d203','width'); %CF17

x21 = X(450:5:750);
y21 = 0.7*x21.^0.68;
loglog(x2,y2,x21,y21,'s','MarkerSize',2);
%% CF21 Gaussian
X = logspace(-2,5,1000);

[y3 x3] = BTPrepPlot('d204','width'); %CF21

x31 = X(480:5:640);
y31 = 0.7*x31.^0.68;
x32 = X(640:5:750);
y32 = 1.65*x32.^0.52;
loglog(x3,y3,x31,y31,'s',x32,y32,'s','MarkerSize',2);
%% CF22 Gaussian
X = logspace(-2,5,1000);

[y4 x4] = BTPrepPlot('d205','width'); %CF22

figure(2);

x41 = X(460:630);
y41 = 0.9*x41.^0.64;
x42 = X(630:760);
y42 = 4.3*x42.^0.35;

loglog(x4,y4,x41,y41,x42,y42);