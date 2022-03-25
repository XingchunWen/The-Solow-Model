/* example to show how to use dynare */
%%
%written by xingchunwen @ uibe, for fun

%Solow Model

var y, c, k, inv; %内生变量
varexo s;    %外生变量

parameters n, delta, theta, sg, s0; %参数

n     = 0.02;
delta = 0.1;
theta = 0.5;
sg    = theta;
s0    = 0.3;%case1: 0.6>sg; case2: 0.3<sg  

model;
k =(1-delta)/(1+n)*k(-1)+s*(k(-1))^theta/(1+n);
y =(k(-1))^theta;
c =(1-s)*(k(-1))^theta;
inv = s*(k(-1))^theta;
end;

initval;
s = s0;
k = ((n+delta)/s0)^(1/(theta-1));
y = ((n+delta)/s0)^(theta/(theta-1));
c = (1-s0)*((n+delta)/s0)^(theta/(theta-1));
inv = s0*((n+delta)/s0)^(theta/(theta-1));
end;

endval;
s = sg;
k = ((n+delta)/sg)^(1/(theta-1));
y = ((n+delta)/sg)^(theta/(theta-1));
c = (1-sg)*((n+delta)/sg)^(theta/(theta-1));
inv = sg*((n+delta)/sg)^(theta/(theta-1));
end;

steady; %确认初始值是不是稳态以及求解稳态
check; %这个命令是计算和展示出方程系统的特征根



shocks;
var s;
periods 1:500;
values 0.5;
end;

simul(periods=500);

// Display the results
nrep    = 95;
smpl    = 0+(1:nrep);

close all
subplot(311);plot([c(1);c(1);c(1);c(1);c(1);c(smpl)],'-b','linewidth',2);title('consumption')
hold on
line([1,nrep+5],[c(nrep),c(nrep)],'linestyle',':','color','green','linewidth',1.5)
hold on
line([1,nrep+5],[c(1),c(1)],'linestyle','-','color','red','linewidth',1.5)
%line([起点横坐标,终点横坐标],[起点纵坐标,终点纵坐标],'linestyle',':')
subplot(312);plot([inv(1);inv(1);inv(1);inv(1);inv(1);inv(smpl)],'-b','linewidth',2);title('investment')
subplot(313);plot([y(1);y(1);y(1);y(1);y(1);y(smpl)],'-b','linewidth',2);title('output') 
