%% ʹ��Apriori�㷨�ھ��������
clc;
clear;
% ������ʼ��
inputfile = 'GUIS\test_sets\test_i.txt';
outputfile = 'as.txt'; % ���ת���� 0 1�����ļ�
% ��Ҫ���ݽ����������޸���С֧�ֶ�
minSup = 0.5; % ��С֧�ֶ�
minCof = 0.5; % ��С���Ŷ�
nRules = 1000; % �����������
sortFlag = 1; % ����֧�ֶ�����
rulefile = 'rules.txt'; % ��������ļ�

%% ����ת������,������ת��Ϊ0 1 ����  �Զ��庯��
[transactions,code] = trans2matrix(inputfile,outputfile,' ');


%% ����Apriori���������㷨���Զ��庯��
[Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code,rulefile);

disp('Apriori�㷨�ھ��Ʒ���������������');