% ����ֵ�Ĳ�������
clear;
r_on=1e05;
r_off=2e07;
V_th_pos=1.5;
V_th_neg=-1;
T_pos=5;
T_neg=1;
time=1:200;
% ��ѹ��1x100�ľ���
t=linspace(0,4,200);
voltage=2.5*sin(2*pi*t);
subplot(2,2,1)
title('��ѹ����')
plot(t,voltage)
xlabel('ʱ��t')
ylabel('��ѹV')
axis([0,4,-2.5,2.5])
% ��С����
dt=0.1;
% ��ʼ����������ֵ
r_i=1e05;
% ������ֵ
resistance=memristor(time,voltage,r_i,dt,r_on,r_off,V_th_pos,V_th_neg,T_pos,T_neg);
subplot(2,2,2)
title('��������ֵ��ʱ��仯ͼ')
plot(time,resistance)
xlabel('ʱ��t')
ylabel('����ֵM')
% ������ֵ
I=voltage./resistance;
subplot(2,2,3)
title('��ѹ-����ֵ')
plot(voltage,resistance)
xlabel('��ѹV')
ylabel('����ֵM')
subplot(2,2,4)
title('�������ķ�����������')
plot(voltage,I)
xlabel('��ѹV')
ylabel('����I')
