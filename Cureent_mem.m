clear;
% Iamp=2e-03;
count =1000;
time=linspace(0,1,count);
% time1=linspace(0,5*pi,count);
% ����
dt = 1;
% �������������ĵ���
R=2000;

% ����ĵ����ź�
Iinput=0.005*sin(2*pi*time);
% Vinput=1*square(time1);
% Iinput=1*square(time);

subplot(2,2,1);
plot(time,Iinput)


title('������ʱ��ı仯')
% ��������
% ת��ΪmA
Ioff=115e-06;
% 8.9����Ϊ��
Ion=-8.9e-06;

arf_on=10;
arf_off=10;

Roff=1000;
Ron=-150;

k_off=1.46e-09;
k_on=-4.68e-13;

a_off=1.2;
a_on=1.8;


x_on=0.8;
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
    % ����x�ķ�Χ
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


subplot(2,2,2);
plot(time,M)
title('M��ʱ��仯')
V=M.*Iinput;


% figure(3)
% plot(time,x);
% title('x��ʱ��仯ͼ')


subplot(2,2,3);
plot(V,Iinput)
title('������������')
xlabel('V')
ylabel('I')

subplot(2,2,4);
plot(x,F_off_x,x,F_on_x);
title('����������')

% subplot(2,3,5);
% weight=M;
% plot(time,weight)
% title('Ȩֵ�仯')

% subplot(2,3,6);
% plot(M,weight)
% title('ͻ��������ֵ�ı仯')




 
        
     
