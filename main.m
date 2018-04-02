%% ʹ��Hopfield�����ھ��������
clear;
global A B C tao n p nRules minCof minSup
% ������ʼ��
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % ���ת�����01����
rulesfile = 'rules.txt'; % �����������
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.3;
minCof = 0.5;
nRules = 100; % ��������
% ���ñ��뺯���������׼�ת��Ϊ01����
[T,code] = trans2matrix(inputfile,outputfile,' ')
% ��Ŀ��
n = size(T,1);
% ��С֧�ֶȼ��� ����ȡ��
minSupCount=ceil(minSup*n);
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
V =(1+tansig(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,100);
k=1;
e=1;
while k<100
    % ���㶯̬����
    dU=diff_u(U,minSupCount,V,T)
    % ����������Ԫ
    U= U+dU*step
    % ���������Ԫ
    disp('�м��V')
    V = (1+tanh(lambda*U))/2
    % ������������
    e = energy(minSupCount,V,T)
    E(k)=e;
    k=k+1
end
% ���Ƶ���
%Frequent=int8(V)
Frequent=V;
[~,index]=find(Frequent==1);
F = unique(index');
disp('���Ƶ���Ϊ:')
code(F)
% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% �����������
R=rule(T,F,S);
% ���������������txt��
fid=fopen(rulesfile,'w');
fprintf(fid,'%s (%s,%s) \n','Rule','Support','Confidence');
for i=1:size(R,1)
    s1 = '';
    s2 = '';
    for j = 1:size(R{i,1},2)
        if j == size(R{i,1},2)
            s1 = [s1 code{R{i,1}(j)}];
        else
            s1 = [s1 code{R{i,1}(j)} ' '];
        end
    end
    %s1=cell2mat(code(R{i,1}));
    for j = 1:size(R{i,2},2)
        if j == size(R{i,2},2)
            s2 = [s2 code{R{i,2}(j)}];
        else
            s2 = [s2 code{R{i,2}(j)} ' '];
        end
    end
    %s2=cell2mat(code(R{i,2}));
    s3=num2str(R{i,3}*100);
    s4=num2str(R{i,4}*100);
    fprintf(fid,'%s -> %s (%s%%,%s%%)\n',s1,s2,s3,s4);
end
fclose(fid);
disp(['�洢�����ļ�' rulesfile '���'])
    

             