%% ʹ��Hopfield�����ھ��������
clear;
global A B C tao n p nRules minCof minSup
% ������ʼ��
inputfile = 't.txt';
outputfile= 'as.txt'; % ���ת�����01����
rulesfile = 'rules.txt'; % �����������
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.5;
minCof = 0.5;
nRules = 100; % ��������
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
step=0.000001; % ���˹���

R =2000; % �������������ĵ���

% ��������Ϊ0-1��p*n�ľ���
% U = T;
U = randi([0,1],n,p);
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,1000);
k=1; %�������� ȡ1000
% �����Ȩֵ����ֵ
[W,I]=newdiff(minSupCount,T);
% M=2000./W-2000;
% M(M==inf)=0;
% Wm=1./M;
% Wm(Wm==inf)=0;
% % 
% I=I./100;
% Iv=0.6*(n*p+2)-I;
% Iv=Iv.*100;

% ��һ������
W1=mapminmax(W,0,1);

% M=2000./W1-2000;
% M(M==inf)=0;
% M1=2000./M;
% for i=1:size(M,1)
%     M(i,i)=0;
% end

dU = zeros(size(U)); %��ʼ��Ϊȫ0����
 while k<100
     % ����du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % ��1��30������ȡ5�г��� ����ʹ��reshape����ı����ݵ�
                Row_M =W1((a-1)*p+i,(b-1)*p+1:b*p);
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
     % ������������
     e = energy(minSupCount,V,T)
     E(k)=e;
     k=k+1
end

% ���������������������
E(k:end)=[];
% ������������ͼ
plot(E)
xlabel('��������')
ylabel('��������')
title('���������仯����')
% ���Ƶ���
Frequent=int8(V);
[~,index]=find(Frequent==1);
F = unique(index');
disp('���Ƶ���Ϊ:')
code(F)
% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�
S = support(T,F);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ�����
R=rule(T,F,S,1);
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
disp(['�洢�����ļ�' rulesfile '���' '������Ϊ' num2str(size(R,1)) '��'])
    

             