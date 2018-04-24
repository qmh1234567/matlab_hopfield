%% ʹ��Hopfield�����ھ��������
clc;
clear;
global A B C tao n p nRules minCof minSup code
%% ������ʼ��
inputfile = 'GUIS\mygoods.txt';
outputfile= 'as.txt'; % ���ת�����01����
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.5;
minCof = 0.5;
nRules = 1000; % ��������

% ���ñ��뺯���������׼�ת��Ϊ01����
[T,code] = trans2matrix(inputfile,outputfile,' ')
% ��Ŀ��
n = size(T,1);
% ��С֧�ֶȼ��� ȡ��ӽ�������
minSupCount=round(minSup*n);
% ������
p = size(T,2);

% ���ݾ���ָ������ر���
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;

% U��ʼ��ΪT
U = T;
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,1000);
k=1; %�������� 

%% �������Ƶ���
% �����Ȩֵ����ֵ
[W,I]=newdiff(minSupCount,T);

% ӳ�䵽����ֵ����
% M=W+100; % ������ֵ����Ȩֵ  ������100
Iv=I./100; % ��ֵ����     

% ��Ȩ��ӳ�䵽����ֵ
M2=W./(max(max(abs(W)))+10); % ��һ��
x=real(fix(log10(max(max(abs(W)))))); %ȡȨ�ص�����
M1=M2*10^x+10^(x-2); % �ɼ��ٵ�������������֤�����׼ȷ��
dU = zeros(size(U)); %��ʼ��Ϊȫ0����

% ��������
if x>4
    step=10^(-(x+3));
else
    step=10^(-(x+2));
end


% ���е������ҳ�Ƶ���
 while k<500
     % ����du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % ��1��30������ȡ5�г��� ����ʹ��reshape����ı����ݵ�
                Row_M =M1((a-1)*p+i,(b-1)*p+1:b*p);
                % V��ÿһ����Rom_w��ÿһ�����
                sum_x = sum_x+ sum(V(b,:).*Row_M);
            end
            if x>4
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-2);
            else
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-3);  
            end
        end
    end
    dU
     % ����������Ԫ
     U= U+dU*step
     % ���������Ԫ
     disp('�м��V')
     V = (1+tanh(lambda*U))/2
     % ����������ȫ0��˵���Ҳ���Ƶ��2��ģ�����ǰ�˳�
     if any(any(V))==0
         break;
     end
     % ������������
     e = energy(minSupCount,V,T)
     E(k)=e;
     k=k+1
 end

%% ������  �����������ߡ����Ƶ�������������
% ���������������������
E(k:end)=[];
% ������������ͼ
plot(E)
xlabel('��������')
ylabel('��������')
title('���������仯����')

% ���Ƶ���
Frequent=int8(V);
index=[];
% ֻ��Ҫȫ1���У�����������1����
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index=[index;i];
     end
end
F = unique(index')
disp('���Ƶ���Ϊ:')
code(F)

% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ�����
R=rule(T,F,S,1);

    

             