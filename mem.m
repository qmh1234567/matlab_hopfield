% 仿真忆阻器阻值的变化
% Rm = Mi+dM*V =》Mi是初始值，dM是变化量   V是激励信号
% Mi相当于实体模型中的Ron和Roff之和的二分之一。dM是Ron和Roff的差值的二分之一。使得Rm在Roff和Ron之间连续变化
% 如果要实现忆阻值在正负之间变化，需要将Mi设置为0
% 根据激励信号的不同，忆阻器随时间的变化值不一样。如果是脉冲信号，就是一种二值模型。
w1=1;
t=linspace(0,4);
% stepfun实现单位阶跃信号
%V = sinc(t-2);
% 正弦信号
V=sin(2*pi*w1*t);
Ron=1000;
Roff=160000;
% Mi=(Ron+Roff)/2;
Mi=0;
dM=(Ron-Roff)/2;
Rm = Mi+dM*V
figure(1)
plot(t,Rm)
title('忆阻器阻值随时间变化')
figure(2)
plot(t,V)
title('激励信号')
% 设定坐标轴显示范围
% axis([-1,4,-0.5,1.5])




