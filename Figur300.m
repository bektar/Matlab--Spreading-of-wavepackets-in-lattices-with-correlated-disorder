[d192L d192X] = BTPrepPlot('d192','correlation','lambda',0.2);
[d194L d194X] = BTPrepPlot('d194','correlation','lambda',0.2);
[d195L d195X] = BTPrepPlot('d195','correlation','lambda',0.2);

[d197L d197X] = BTPrepPlot('d197','correlation','lambda',0.2);
[d198L d198X] = BTPrepPlot('d198','correlation','lambda',0.2);
[d199L d199X] = BTPrepPlot('d199','correlation','lambda',0.2);

[w192 x192] = BTPrepPlot('d192','width','mean'); % S=10K,K(r)=CF17,L=0.2
[w194 x194] = BTPrepPlot('d194','width','mean'); % S=10K,K(r)=CF21,L=0.2
[w195 x195] = BTPrepPlot('d195','width','mean'); % S=10K,K(r)=CF22,L=0.2

[p192 x192] = BTPrepPlot('d192','participation','mean'); % S=10K,K(r)=CF17,L=0.2
[p194 x194] = BTPrepPlot('d194','participation','mean'); % S=10K,K(r)=CF21,L=0.2
[p195 x195] = BTPrepPlot('d195','participation','mean'); % S=10K,K(r)=CF22,L=0.2

[w203 x203] = BTPrepPlot('d203','width','mean'); % S=10K,K(r)=CF17,L=0.2
[w204 x204] = BTPrepPlot('d204','width','mean'); % S=10K,K(r)=CF21,L=0.2
[w205 x205] = BTPrepPlot('d205','width','mean'); % S=10K,K(r)=CF22,L=0.2

[p203 x203] = BTPrepPlot('d203','participation','mean'); % S=10K,K(r)=CF17,L=0.2
[p204 x204] = BTPrepPlot('d204','participation','mean'); % S=10K,K(r)=CF21,L=0.2
[p205 x205] = BTPrepPlot('d205','participation','mean'); % S=10K,K(r)=CF22,L=0.2
%%
figure(300);
subplot(3,1,1);
plot(d192X,d192L,d194X,d194L,d195X,d195L);%,d197X,d197L,d198X,d198L,d199X,d199L);
legend('K(r)=sin(1.3r)/(1.5r)','K(r)=sin(2.5r)/(2.6r)','K(r)=sin(3.0r)/(3.1r)',...
       'Location','NorthWest');
                        xlabel('Energy');
ylim([0 0.02]);         ylabel('\Lambda(E)');
title('Jobs: d192,d194,d195 | CF17,CF21,CF22 | Sites = 10 000');

subplot(3,1,[2 3]);
loglog(x192,w192,'b',x194,w194,'g',x195,w195,'r',x192,p192,'b',x194,p194,'g',x195,p195,'r',...
       x203,w203,'b',x204,w204,'g',x205,w205,'r',x203,p203,'b',x204,p204,'g',x205,p205,'r');
xlim([10^-1 10^5]);      xlabel('Time');
ylim([10^-1 10^3.5]);  ylabel('Width and Participation');