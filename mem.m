% ������������ֵ�ı仯
% Rm = Mi+dM*V =��Mi�ǳ�ʼֵ��dM�Ǳ仯��   V�Ǽ����ź�
% Mi�൱��ʵ��ģ���е�Ron��Roff֮�͵Ķ���֮һ��dM��Ron��Roff�Ĳ�ֵ�Ķ���֮һ��ʹ��Rm��Roff��Ron֮�������仯
% ���Ҫʵ������ֵ������֮��仯����Ҫ��Mi����Ϊ0
% ���ݼ����źŵĲ�ͬ����������ʱ��ı仯ֵ��һ��������������źţ�����һ�ֶ�ֵģ�͡�
w1=1;
t=linspace(0,4);
% stepfunʵ�ֵ�λ��Ծ�ź�
%V = sinc(t-2);
% �����ź�
V=sin(2*pi*w1*t);
Ron=1000;
Roff=160000;
% Mi=(Ron+Roff)/2;
Mi=0;
dM=(Ron-Roff)/2;
Rm = Mi+dM*V
figure(1)
plot(t,Rm)
title('��������ֵ��ʱ��仯')
figure(2)
plot(t,V)
title('�����ź�')
% �趨��������ʾ��Χ
% axis([-1,4,-0.5,1.5])



