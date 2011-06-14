% Visa den här och "Correlation.m" samtidigt. Lila och gula kurvorna
% är extra intressanta.

[y1 x1] = BTPrepPlot('d237','width'); %zeros
[y2 x2] = BTPrepPlot('d203','width'); %CF17
[y3 x3] = BTPrepPlot('d204','width'); %CF21
[y4 x4] = BTPrepPlot('d205','width'); %CF22
[y5 x5] = BTPrepPlot('d214','width'); %Rand
[y6 x6] = BTPrepPlot('d239','width');
[y7 x7] = BTPrepPlot('d243','width');

figure(2);
loglog(x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7);

legend('CF17','CF21','CF22','Random','CF00(r,1.8,1.85,1.06)',...
        'CF00(r,1.8,1.85,1.1)','Location','NorthWest');
title('Width - Gaussian wavepacket');
xlim([1 10000]);

[y2 x2] = BTPrepPlot('d192','width'); %CF17
[y3 x3] = BTPrepPlot('d194','width'); %CF21
[y4 x4] = BTPrepPlot('d195','width'); %CF22
[y5 x5] = BTPrepPlot('d213','width'); %Rand
[y6 x6] = BTPrepPlot('d206','width');
[y7 x7] = BTPrepPlot('d207','width');

figure(1);
loglog(x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7);
legend('CF17','CF21','CF22','Random','CF00(r,1.8,1.85,1.06)',...
        'CF00(r,1.8,1.85,1.1)','Location','NorthWest');
title('Width - Spike wavepacket');
xlim([10 100000]); ylim([10 100000]); grid on;