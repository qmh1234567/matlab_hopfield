%% ʹ��Apriori�㷨�ھ��������
function [Max_Req,Rcount]=Copy_of_cal_apriori(transactions,code)
% ������ʼ��
% inputfile = 'test1.txt';
% outputfile = 'as.txt'; % ���ת���� 0 1�����ļ�
% ��Ҫ���ݽ����������޸���С֧�ֶ�
minSup = 0.5; % ��С֧�ֶ�
minCof = 0.5; % ��С���Ŷ�
nRules = 1000; % �����������
sortFlag = 1; % ����֧�ֶ�����
rulefile = 'rules.txt'; % ��������ļ�

%% ����ת������,������ת��Ϊ0 1 ����  �Զ��庯��
% [transactions,code] = trans2matrix(inputfile,outputfile,' ');


%% ����Apriori���������㷨���Զ��庯��
[Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code,rulefile);


% �������Ƶ���
Max_Req=[];
for i=2:size(FreqItemsets,2)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
        Max_Req=[Max_Req code(matrix(j,:))];
    end
end
Max_Req=unique(Max_Req);


Rcount=size(Rules{1},1); % ���ع�����������

disp('Apriori�㷨�ھ��Ʒ���������������');