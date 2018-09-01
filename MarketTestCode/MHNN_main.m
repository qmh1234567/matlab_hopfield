%% ʹ������Hopfield�����ھ��������
clc;
clear;
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.5;
minCof = 0.5;
nRules = 10000; % ��������
% ���ݾ���ָ������ر���
tao = 1;
lambda =3;
%% ���ɽ��׼�
%% ������ʼ��
inputfile = 'test1.txt';
outputfile= 'as.txt'; % ���ת�����01����
% ���ñ��뺯���������׼�ת��Ϊ01����
[T,code]= trans2matrix(inputfile,outputfile,' ');
% % ��Ŀ��
n = size(T,1);
% ��С֧�ֶȼ��� ȡ��ӽ�������
minSupCount=round(minSup*n);
% % ������
p = size(T,2);
% U��ʼ��ΪT
U = T;
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,1000);

%% �������Ƶ���
N=n*p;
% �����Ȩֵ����ֵ
[W,I]=newdiff(minSupCount,T,n,p);
Iv=I./100; % ��ֵ����   
%% ��Ȩ�ؾ�����д���
% ����Ԫ���������Ȩ�ؾ�������ֵ
MaxValue=1;
for i=1:N
    newMaxValue=max(abs(W{i}));
    if MaxValue<newMaxValue
        MaxValue=newMaxValue;
    end
end
% ��Ȩ�ؾ�����й�һ��
W1=W;
for i=1:N
    W1{i}=W{i}./(MaxValue+10);
end
% ȡȨ�����ֵ������
x=real(fix(log10(MaxValue)));
% �µ�Ȩ��
W2=W1;
for i=1:N
    W2{i}=W1{i}*10^x+10^(x-2);
end
%% ������������Ͳ���
% ��������
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=500;
end
%% �ҳ����Ƶ���
dU = zeros(size(U)); %��ʼ��Ϊȫ0����
% ���е������ҳ�Ƶ���
k=1;%��������
 while k<Count
     m=1;% Ȩ�ؾ����������ʼ��
     % ����du
    for a=1:n
        for i=1:p
            sum_x = W2{m}*reshape(V',[N,1]);%��ԭ��n��p�е���������ع�ΪN��1��
            if x>4
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-2);
            else
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-3);  
            end
            m=m+1;
        end
    end
     % ����������Ԫ
     U= U+dU*step;
     V = (1+tanh(lambda*U))/2;
     % ����������ȫ0��˵���Ҳ���Ƶ��2��ģ�����ǰ�˳�
     if any(any(V))==0
         break;
     end
     % ������������
    e = energy(minSupCount,V,T,n,p);
    E(k)=e;
    k=k+1;
 end

%% ������  �����������ߡ����Ƶ�������������
% ���������������������
E(k:end)=[];
% ������������ͼ
plot(E)
xlabel('��������')
ylabel('��������')
title('���������仯����')

% ������Ƶ���
Frequent=int8(V);
index=zeros(1,size(Frequent,2));
k=1;
% ֻ��Ҫȫ1���У�����������1����
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index(k)=i;
         k=k+1;
     end
end
index(k:end)=[];
F = unique(index');
disp('���Ƶ���Ϊ:')
code(F)

% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�  ֧�ֶ�Ϊ0.3
S = support(T,F,minSup);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ�����,0��main  1��copyofmain,���Ŷ�Ϊ0.3
R=rule(S,1,1,minCof,code);


    

                