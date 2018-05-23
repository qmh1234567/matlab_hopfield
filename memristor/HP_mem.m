% 惠普忆阻器模型的仿真
% 参数定义
% Uv=1e-14;
% Ron=1000;
% Roff=160000;
% p=1;
% Count=100;
% time=linspace(0,1,Count);
% dt=0.01;
% % 电压
% V=sin(2*pi*time);
% D=1e-8;
% HP_mem(V,Uv,D,Ron,Roff,p,Count,dt);
function HP_mem(Uv,D,Ron,Roff,p,dt)
    Count=200; %迭代次数
    time=linspace(0,2,Count); 
    V=sin(2*pi*time); %电压
    k=Uv*Ron/(D*D);
    % 预分配空间
     F=zeros(1,Count);M=zeros(1,Count);x=zeros(1,Count);I=zeros(1,Count);
     x(1,1)=0.3; % x的初始值
    for t=1:Count
        F(t)=1-(2*x(t)-1)^(2*p);
        dx=k*F(t)*I(t);
        M(t)=Roff+(Ron-Roff)*x(t);
        if t<Count
            I(t+1)=V(t)/M(t);
            x(t+1)=x(t)+dx*dt;
        end
    end
    plot(V,I,'b')
    title('伏安特性曲线');xlabel('V(v)');ylabel('I(A)')
end
 




