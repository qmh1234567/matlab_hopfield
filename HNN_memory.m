%% ������������hopfield����ʵ���������
clc;
clear;
Wm=[0 8 0.5;8 0 0.85;0.5 0.85 0].*1000;

Theta_v=[4;2;3.1];

U=[1;0;0]; % ��Ԫ������

Y=[1;0;0]; % ��Ԫ���

Y1=[1;0;1];

W=zeros(3,3);

R=2000; %����

% ����Ȩ��
for i=1:size(W,1)
for j=1:size(W,2)
    if Wm(i,j)~=0
         W(i,j)=R/(Wm(i,j)+R);
    end
end
end


for i=1:size(U)
    if isequal(Y,Y1)==1
        break
    else
        sum1=sum(Y(i).*W(i,:));
        U(i)=sum1+Theta_v(i);
        if U(i)>3
            Y(i)=1;
        else
            Y(i)=0;
        end
        i
        Y
    end
end 

