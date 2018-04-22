% 忆阻值的参数设置
clear;
r_on=1e05;
r_off=2e07;
V_th_pos=1.5;
V_th_neg=-1;
T_pos=5;
T_neg=1;
time=1:200;
% 电压是1x100的矩阵
t=linspace(0,4,200);
voltage=2.5*sin(2*pi*t);
subplot(2,2,1)
title('电压曲线')
plot(t,voltage)
xlabel('时间t')
ylabel('电压V')
axis([0,4,-2.5,2.5])
% 最小步长
dt=0.1;
% 初始的忆阻器阻值
r_i=1e05;
% 忆阻阻值
resistance=memristor(time,voltage,r_i,dt,r_on,r_off,V_th_pos,V_th_neg,T_pos,T_neg);
subplot(2,2,2)
title('忆阻器阻值随时间变化图')
plot(time,resistance)
xlabel('时间t')
ylabel('忆阻值M')
% 电流的值
I=voltage./resistance;
subplot(2,2,3)
title('电压-忆阻值')
plot(voltage,resistance)
xlabel('电压V')
ylabel('忆阻值M')
subplot(2,2,4)
title('忆阻器的伏安特性曲线')
plot(voltage,I)
xlabel('电压V')
ylabel('电流I')
