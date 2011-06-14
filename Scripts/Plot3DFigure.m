figure();
BatchName  = 'd192';
t = [1 765 770 773 1000];

[y1 x1] = BTPrepPlot(BatchName,'wave','time',t(1));
[y2 x2] = BTPrepPlot(BatchName,'wave','time',t(2));
[y3 x3] = BTPrepPlot(BatchName,'wave','time',t(3));
[y4 x4] = BTPrepPlot(BatchName,'wave','time',t(4));
[y5 x5] = BTPrepPlot(BatchName,'wave','time',t(5));

z5 = zeros(size(x1,1),size(x1,2)) + 1;
z4 = zeros(size(x1,1),size(x1,2)) + 2;
z3 = zeros(size(x1,1),size(x1,2)) + 3;
z2 = zeros(size(x1,1),size(x1,2)) + 4;
z1 = zeros(size(x1,1),size(x1,2)) + 5;

plot3(x1,z1,y1,x2,z2,y2,x3,z3,y3,x4,z4,y4,x5,z5,y5);
zlim([0 0.0005]);
grid on;
xlabel('Site');zlabel('|\Psi|^2');%ylabel('Time');