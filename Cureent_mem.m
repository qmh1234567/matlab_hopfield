clear;
% Iamp=2e-03;
count = 1000;
time=linspace(0,1,count);
% 步长
dt = 1;
% 输入的电流信号

Iinput=0.005*sin(2*pi*time);
figure(1)
plot(time,Iinput)
title('电流随时间的变化')
% 参数定义
% 转化为mA
Ioff=115e-06;
Ion=-8.9e-06;

arf_on=10;
arf_off=10;

Roff=1000;
Ron=50;

k_off=1.46e-09;
k_on=-4.68e-13;

a_off=1.2;
a_on=1.8;


x_on=0.8;
x_off=2.4;

wc=0.1;

% 为M分配空间
M = zeros(1,count);

%x的取值
x=zeros(1,count);
% 约定x的初始值
x(1) =0;
% dx的范围
dx=zeros(1,count);

% t是迭代次数
for t=1:count
    if(0<Ioff && Ioff<Iinput(t))
        % 窗函数
        Foff=exp(-exp(x(t)-a_off)/wc);
        dx(t)=k_off*(Iinput(t)/Ioff-1)^arf_off*Foff*dt;
        x(t+1)=dx(t)+x(t);
    end
    if(Iinput(t)>Ion && Iinput(t)<Ioff)
         dx(t)=0;
         x(t+1)=dx(t)+x(t);
    end
    if(Iinput(t)<Ion && Ion<0)
        % 窗函数
         Fon=exp(-exp(a_on-x(t))/wc);
         dx(t)=k_on*(Iinput(t)/Ion-1)^arf_on*Fon*dt;
         x(t+1)=dx(t)+x(t);
    end
    % 控制x的范围
     if x(t) > x_off
        x(t) = x_off;
     elseif x(t) < x_on
         x(t) = x_on;
     end
    M(t)=Ron+(Roff-Ron)/(x_off-x_on)*(x(t)-x_on);
   
end
% 去掉x的最后一个数据
x=x(1:count);
% 计算窗函数
F_off_x=exp(-exp((x-a_off)./wc));
F_on_x=exp(-exp((a_on-x)./wc));


figure(2);
plot(time,M)
title('M随时间变化')
V=M.*Iinput;

% figure(3)
% plot(time,x);
% title('x随时间变化图')


figure(4);
plot(V,Iinput)
title('伏安特性曲线')
xlabel('V')
ylabel('I')

figure(5)
plot(x,F_off_x,x,F_on_x);
title('窗函数曲线')

 
        
     
