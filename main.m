%% ʹ��Hopfield�����ھ��������
clear;
global A B C tao n p nRules minCof
% ������ʼ��
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % ���ת�����01����
rulesfile = 'rules.txt'; % �����������
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 2;
minCof = 0.5;
nRules = 100; % ��������
% ���ñ��뺯���������׼�ת��Ϊ01����
[T,code] = trans2matrix(inputfile,outputfile,' ')
% ��Ŀ��
n = size(T,1);
% ������
p = size(T,2);
% ���ݾ���ָ������ر���
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;
step=0.0001; % ���˹���
% ��������Ϊ0-1��p*n�ľ���
%U = T;
U = randi([0,1],n,p);
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,100);
k=1;
while k<5
    % ���㶯̬����
    dU=diff_u(U,minSup,V,T)
    % ����������Ԫ
    U= U+dU*step;
    % ���������Ԫ
    disp('�м��V')
    V = (1+tanh(lambda*U))/2
    % ������������
    e = energy(minSup,V,T);
    E(k)=e;
    k=k+1
end
% ���Ƶ���
Frequent=int8(V)
[~,index]=find(Frequent==1);
F = unique(index');
disp('���Ƶ���Ϊ:')
code(F)
% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% �����������
R=rule(T,F,S);


             