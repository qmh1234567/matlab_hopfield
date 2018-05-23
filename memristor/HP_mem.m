% ����������ģ�͵ķ���
% ��������
% Uv=1e-14;
% Ron=1000;
% Roff=160000;
% p=1;
% Count=100;
% time=linspace(0,1,Count);
% dt=0.01;
% % ��ѹ
% V=sin(2*pi*time);
% D=1e-8;
% HP_mem(V,Uv,D,Ron,Roff,p,Count,dt);
function HP_mem(Uv,D,Ron,Roff,p,dt)
    Count=200; %��������
    time=linspace(0,2,Count); 
    V=sin(2*pi*time); %��ѹ
    k=Uv*Ron/(D*D);
    % Ԥ����ռ�
     F=zeros(1,Count);M=zeros(1,Count);x=zeros(1,Count);I=zeros(1,Count);
     x(1,1)=0.3; % x�ĳ�ʼֵ
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
    title('������������');xlabel('V(v)');ylabel('I(A)')
end
 




