scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)-1024 scrsz(4)-768 1024 768]);
% 'Name','Simulation Plot Window','NumberTitle','off',...

%%
loglog(d053_L01_Time,d053_L01_Width,...
       d053_L02_Time,d053_L02_Width,...
       d053_L03_Time,d053_L03_Width);
%%
xlabel('Time');
ylabel('Width');

xlim([10^-0 10^5]);
ylim([10^-0 10^4]);

title('K(r)=sin(1.3r)/(1.5r), S=2*10^4');
suptitle('d053 - Diffusion of spike with narrow plateau  ');

legend('\lambda = 0.1','\lambda = 0.2','\lambda = 0.3',...
       'Location','NorthWest');