X = logspace(-2,5,1000);
%% CF17 Spike
[y2 x2] = BTPrepPlot('d192','width'); %CF17

x21 = X(100:550);
y21 = 1.43*x21;
x22 = X(550:700);
y22 = 2.13*x22.^0.9;

figure(2);
loglog(x2,y2,x21,y21,x22,y22);
xlim([1 100]); ylim([1 100]);

%% CF21 Spike
[y3 x3] = BTPrepPlot('d194','width'); %CF21

x31 = X(600:760);
y31 = 2.7*x31.^0.83;
x32 = X(550:600);
y32 = 2.35*x32.^0.86;
figure(3);
loglog(x3,y3,x31,y31,x32,y32);
xlim([50 3000]); ylim([50 2000]);

%% CF22 Spike
[y4 x4] = BTPrepPlot('d195','width'); %CF22

x41 = X(650:760);
y41 = 9*x41.^0.6;
x42 = X(600:650);
y42 = 4.5*x42.^0.72;
x43 = X(550:600);
y43 = 3.3*x43.^0.78;

figure(4);
loglog(x4,y4,x41,y41,x42,y42,x43,y43);
xlim([50 3000]); ylim([50 2000]);

%% CF00(r,1.8,1.85,1.06)  d206

[y5 x5] = BTPrepPlot('d206','width');

x51 = X(100:700);
y51 = x51.^1.00;
figure(5);
loglog(x5,y5,x51,y51);
%xlim([50 3000]); ylim([50 2000]);

%% CF00(r,1.8,1.85,1.1)   d207
[y6 x6] = BTPrepPlot('d207','width');

x61 = X(100:700);
y61 = x61.^1.00;
figure(6);
loglog(x6,y6,x61,y61);
%xlim([50 3000]); ylim([50 2000]);

%%  Zeros   d236
[y1 x1] = BTPrepPlot('d236','width');

X = logspace(-2,5,1000);
x2 = X(100:700);
y2 = 1.46.*x2;

figure(7);
loglog(x1,y1,x2,y2);
title('Width - Spike wavepacket');
xlim([10 3000]); ylim([10 3000]); grid on;