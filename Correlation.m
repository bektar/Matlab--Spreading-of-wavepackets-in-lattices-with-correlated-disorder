[y2 x2] = BTPrepPlot('d192','correlation','lambda',0.2); %CF17
[y3 x3] = BTPrepPlot('d194','correlation','lambda',0.2); %CF21
[y4 x4] = BTPrepPlot('d195','correlation','lambda',0.2); %CF22
[y5 x5] = BTPrepPlot('d213','correlation','lambda',0.2); %Rand
[y6 x6] = BTPrepPlot('d239','correlation','lambda',0.2);
[y7 x7] = BTPrepPlot('d243','correlation','lambda',0.2);
%%
figure(30);
plot(x2,y2,x3,y3,x4,y4,x5,y5,x6,y6,x7,y7);
legend('CF17','CF21','CF22','Random','CF00(r,1.8,1.85,1.06)',...
        'CF00(r,1.8,1.85,1.1)','Location','NorthWest');
title('Correlation');
ylim([0 0.01]);