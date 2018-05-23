%% ʹ��Hopfield�����ھ��������
function [E Freq R]=main(inputfile)
global A B C tao n p nRules minCof minSup code
%% ������ʼ��
% inputfile = 'mygoods.txt';
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
[W,I]=newdiff(minSupCount,T);
x=real(fix(log10(max(max(abs(W)))))); %ȡȨ�ص�����
dU = zeros(size(U)); %��ʼ��Ϊȫ0����

% ���������͵�������
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=500;
end


% ���е������ҳ�Ƶ���
 while k<Count
     % ����du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % ��1��30������ȡ5�г��� ����ʹ��reshape����ı����ݵ�
                Row_M =W((a-1)*p+i,(b-1)*p+1:b*p);
                % V��ÿһ����Rom_w��ÿһ�����
                sum_x = sum_x+ sum(V(b,:).*Row_M);
            end
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);
        end
    end
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
% figure;
% plot(E)
% xlabel('��������')
% ylabel('��������')
% title('���������仯����')


% ���Ƶ���
Frequent=int8(V);
index=[];
% ֻ��Ҫȫ1���У�����������1����
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index=[index;i];
     end
end
F = unique(index');
disp('���Ƶ���Ϊ:')
Freq= code(F)

% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ�����  0����oldmain  1����main
R=rule(T,F,S,1,0);

    

             