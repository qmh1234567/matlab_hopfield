%% ʹ��Hopfield�����ھ��������
function [E Freq R]=Copy_of_main(T,code1)
global A B C tao  nRules minCof minSup 
code=code1;
% ��С֧�ֶȼ��� ȡ��ӽ�������
n=size(T,1); % ���״���
p=size(T,2); % ��Ʒ����
minSupCount=round(minSup*n);
%% ������ʼ��
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.5;
minCof = 0.5;
nRules = 1000; % ��������
% ���ݾ���ָ������ر���
A = 350;
B = 100;
C = 110;
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
[W,I]=newdiff(minSupCount,T,n,p);

% ӳ�䵽����ֵ����
% M=W+100; % ������ֵ����Ȩֵ  ������100
Iv=I./100; % ��ֵ����     

% ��Ȩ��ӳ�䵽����ֵ
M2=W./(max(max(abs(W)))+10); % ��һ��
x=real(fix(log10(max(max(abs(W)))))); %ȡȨ�ص�����
M1=M2*10^x+10^(x-2); % �ɼ��ٵ�������������֤�����׼ȷ��
dU = zeros(size(U)); %��ʼ��Ϊȫ0����

% ���������͵�������
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=800;
end


% ���е������ҳ�Ƶ���
 while k<Count
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
     % ����������Ԫ
     U= U+dU*step;
     % ���������Ԫ
     V = (1+tanh(lambda*U))/2;
     % ����������ȫ0��˵���Ҳ���Ƶ��2��ģ�����ǰ�˳�
     if any(any(V))==0
         break;
     end
     % ������������
     e = energy(minSupCount,V,T,n,p);
     E(k)=e;
     k=k+1
 end

%% ������  �����������ߡ����Ƶ�������������
% ���������������������
E(k:end)=[];


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
Freq = code(F)

% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ����� 0����oldmain  1����main 3����copyofmain
R=rule(T,F,S,1,3,code);
% R={};
    

                