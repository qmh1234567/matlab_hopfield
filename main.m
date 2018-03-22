%% ʹ��Hopfield�����ھ��������
clear;
global A B C tao
% ������ʼ��
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % ���ת�����01����
rulesfile = 'rules.txt'; % �����������
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 2;
minCof = 0.5;
nRules = 100; % ��������
% ���ñ��뺯���������׼�ת��Ϊ01����
[transaction,code] = trans2matrix(inputfile,outputfile,' ')
T = transaction;
% ��Ŀ��
p = size(T,1);
% ������
n = size(T,2);
% ���ݾ���ָ������ر���
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;
step=0.0001;
% ��������Ϊ0-1��p*n�ľ���
U = randi([0,1],p,n);
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
iter_num = 5; %��������
E = zeros(1,iter_num);

for k = 1:iter_num
    % ���㶯̬����
    dU=diff_u(U,minSup,V,T);
    % ����������Ԫ
    U= U+dU*step;
    % ���������Ԫ
    disp('�м��V')
    V = (1+tanh(lambda*U))/2
    % ������������
    e = energy(minSup,V,T);
end

disp('����V')
disp(V)
% �������Ԫ�� �����Ԫ����A�е�������
%[rows,cols]=size(V);
%V1=zeros(rows,cols);
%[V_max,V_ind]=max(V);
%for j=1:cols
%    V1(V_ind(j),j)=1;
%end
%disp(V1)
             


