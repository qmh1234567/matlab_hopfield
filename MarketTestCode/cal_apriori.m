%% ʹ��Apriori�㷨�ھ��������
clc;
clear;
% ������ʼ��
inputfile = 'test1.txt';
outputfile = 'as.txt'; % ���ת���� 0 1�����ļ�
% ��Ҫ���ݽ����������޸���С֧�ֶ�
minSup = 0.01; % ��С֧�ֶ�
minCof = 0.1; % ��С���Ŷ�
nRules = 1000; % �����������
sortFlag = 1; % ����֧�ֶ�����
rulefile = 'rules.txt'; % ��������ļ�
Rcount=zeros(1,1000);
minRow=1;
k=1;
%% ����ת������,������ת��Ϊ0 1 ����  �Զ��庯��
while minRow<1000 
    [transactions,code] = trans2matrix(inputfile,outputfile,' ',minRow);
    minRow=minRow+20;
    %% ����Apriori���������㷨���Զ��庯��
    [Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code,rulefile);
    disp('Apriori�㷨�ھ��Ʒ���������������');
    Rcount(1,k)=size(Rules{1},1);
    k=k+1;
end
plot(Rcount)