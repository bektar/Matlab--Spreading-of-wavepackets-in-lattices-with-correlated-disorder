[w197 x197] = BTPrepPlot('d197','width','mean'); % S=10K,K(r)=CF17,L=0.2
[w198 x198] = BTPrepPlot('d198','width','mean'); % S=10K,K(r)=CF21,L=0.2
[w199 x199] = BTPrepPlot('d199','width','mean'); % S=10K,K(r)=CF22,L=0.2

[p197 x197] = BTPrepPlot('d197','participation','mean'); % S=10K,K(r)=CF17,L=0.2
[p198 x198] = BTPrepPlot('d198','participation','mean'); % S=10K,K(r)=CF21,L=0.2
[p199 x199] = BTPrepPlot('d199','participation','mean'); % S=10K,K(r)=CF22,L=0.2
%%
figure(400);
subplot(3,1,1);
plot(d197X,d197L,d198X,d198L,d199X,d199L);%,d197X,d197L,d198X,d198L,d199X,d199L);
legend('K(r)=sin(1.3r)/(1.5r)','K(r)=sin(2.5r)/(2.6r)','K(r)=sin(3.0r)/(3.1r)',...
       'Location','NorthWest');
                        xlabel('Energy');
ylim([0 0.02]);         ylabel('\Lambda(E)');
title('Jobs: d197,d198,d199 | CF17,CF21,CF22 | Sites = 20 000');

subplot(3,1,[2 3]);
loglog(x197,w197,'b',x198,w198,'g',x199,w199,'r',x197,p197,'b',x198,p198,'g',x199,p199,'r');
xlim([10^1 10^5]);      xlabel('Time');
ylim([10^1 10^3.5]);  ylabel('Width and Participation');