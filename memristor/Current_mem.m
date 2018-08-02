clear;
% Iamp=2e-03;
count =1000;
time=linspace(0,1,count);
% ����
dt = 1;
% �������������ĵ���
R=30000;

% ����ĵ����ź�
Iinput=0.005*sin(2*pi*time);
subplot(2,2,1);
plot(time,Iinput,'b')
title('������ʱ��ı仯')
xlabel({'t/s','a'})
ylabel('I(A)')

% ��������
% ת��ΪmA
Ioff=115e-06;
% ����Ϊ��ֵ
Ion=-8.9e-06;

arf_on=12;
arf_off=12;

Roff=3e06;
Ron=100;

k_off=1.46e-09;
k_on=-4.68e-13;

a_off=1.2;
a_on=1.8;


x_on=0;
x_off=2.4;

wc=0.1;

% ΪM����ռ�
M = zeros(1,count);

%x��ȡֵ
x=zeros(1,count);
% Լ��x�ĳ�ʼֵ
x(1) =0;
% dx�ķ�Χ
dx=zeros(1,count);


% t�ǵ�������
for t=1:count
    if(0<Ioff && Ioff<Iinput(t))
        % ������
        Foff=exp(-exp(x(t)-a_off)/wc);
        dx(t)=k_off*(Iinput(t)/Ioff-1)^arf_off*Foff*dt;
        x(t+1)=dx(t)+x(t);
    end
    if(Iinput(t)>Ion && Iinput(t)<Ioff)
         dx(t)=0;
         x(t+1)=dx(t)+x(t);
    end
    if(Iinput(t)<Ion && Ion<0)
        % ������
         Fon=exp(-exp(a_on-x(t))/wc);
         dx(t)=k_on*(Iinput(t)/Ion-1)^arf_on*Fon*dt;
         x(t+1)=dx(t)+x(t);
    end
%     ����x�ķ�Χ
     if x(t) > x_off
        x(t) = x_off;
     elseif x(t) < x_on
         x(t) = x_on;
     end
    M(t)=Ron+(Roff-Ron)/(x_off-x_on)*(x(t)-x_on);
end
% ȥ��x�����һ������
x=x(1:count);

% ���㴰����
F_off_x=exp(-exp((x-a_off)./wc));
F_on_x=exp(-exp((a_on-x)./wc));

V=M.*Iinput;%�����ѹ

subplot(2,2,2);
plot(time,M,'b')
title('M��ʱ��仯')
xlabel({'t/s','b'})
ylabel('M')

% figure(3)
% plot(time,x);
% title('x��ʱ��仯ͼ')


subplot(2,2,3);
plot(V,Iinput,'b')
title('������������')
xlabel({'V(v)','c'})
ylabel('I(A)')

subplot(2,2,4);
h3=plot(x,F_off_x,x,F_on_x);
title('����������')
legend('foff','fon','WestOutside');
xlabel({'x(nm)','d'})
ylabel('f(x)')

figure(2)
% subplot(1,3,1);
% w=M./(M+R);
% plot3(time,M,w)
% title('ͻ��,����ֵ��ʱ��ı仯��ϵͼ');
% xlabel({'time/s','a'})
% ylabel('M/��')
% zlabel('W/��')
% grid on

% ͻ��������ֵ�ı仯
subplot(1,2,1)
plot(time,M)
title('����ֵ��ʱ��ı仯');
xlabel({'time/s','a'})
ylabel('M/��')

% ͻ��������ֵ�ı仯
subplot(1,2,2)
w=M./(M+R);
plot(M,w)
title('ͻ��������ֵ�ı仯');
xlabel({'M/��','b'})
ylabel('W/��')

% figure(3)
% subplot(1,4,1);
% plot(time,Iinput);
% title('������ʱ��ı仯')
% xlabel({'t/s','a'})
% ylabel('I(A)')
% 
% subplot(1,4,2);
% plot(time,V);
% title('��ѹ��ʱ��ı仯');
% xlabel({'t/s','b'})
% ylabel('V(v)')
% 
% subplot(1,4,3);
% plot(V,Iinput);
% title('������������');
% xlabel({'V(v)','c'})
% ylabel('I(A)')
% 
% subplot(1,4,4);
% plot3(time,V,Iinput)
% title('������������(��ά��')
% xlabel('time/s')
% ylabel({'V(v)','d'})
% zlabel('I(A)') 
% grid on
% hold on
% plot3(zeros(1,count),V,Iinput)






 
        
     
