%% init
set(0,'defaultfigurecolor','w');

%% simulation & fig setting
fig_shape = false;

%% model parameters
if ~exist("delay", "var")
    delay = 0.01;
end
if ~exist("kalpha", "var")
    kalpha = 0.5;
end
if ~exist("kbeta", "var")
    kbeta = 1.5;
end

%% leader dynamic
% vx = vel_x, vy = vel_y*cos(w_y*t)+c_y;
vel_x = 0.1;
vel_y = 0.5;
w_y = 0.5;
c_y = 0;

%% formation shape & leader num
leaderNum = 3;
P=2*[2 0;
    1 1;
    1 -1;
    0 1.2;
    0 -1.2;
    -1 1;
    -1 -1;
    -2 0.5;
    -2 -0.5];
if ~exist("P0", "var")
    P0 = [2 0;
          1 1;
          1 -1;
          1 2.2;
          -1 -2.2;
          1 3;
          -3 -3;
          1 3.5;
          -5 -3.5];
end
dim = size(P,2);

%% undirected adjacent matrix
nodenum = size(P,1);
followerNum = nodenum - leaderNum;
neighborMat=zeros(nodenum,nodenum);
neighborMat(1,2)=1;neighborMat(1,3)=1;neighborMat(1,8)=1;neighborMat(1,9)=1;
neighborMat(2,4)=1;neighborMat(2,7)=1;
neighborMat(3,5)=1;neighborMat(3,6)=1;neighborMat(3,4)=1;neighborMat(2,5)=1;
neighborMat(4,5)=1;neighborMat(4,6)=1;neighborMat(2,7)=1;neighborMat(4,7)=0;
neighborMat(5,7)=1;neighborMat(5,8)=0;neighborMat(5,6)=0;
neighborMat(6,7)=1;neighborMat(6,8)=1;
neighborMat(7,9)=1;
neighborMat(8,9)=1;
m=sum(sum(neighborMat)); % number of edges
neighborMat=neighborMat+neighborMat';

%% stress matrix
% note: stress matrix returned is -Omega
stressMat=-fcn_StressMatrix(2,nodenum,m,P,neighborMat,fig_shape);