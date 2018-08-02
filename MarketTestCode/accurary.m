%% �ýű����������������������ܵ�
% ���Լ���������
function [ac1,ac2]=accurary(n,p,testCount)
% ������Ĳ���
p1=0.5; % 1���ֵĸ���
minSup = 0.5;
% Apriori�㷨 ����Hopfield���� hopfield��������Ƶ���
Apr_MaxFeq=cell(testCount,1);
Mh_MaxFeq=cell(testCount,1);
H_MaxFeq=cell(testCount,1);
% ����Apriori�㷨 ����Hopfield���� Hopfield���� �Ĺ�����
Res_Ap=zeros(1,testCount);
Res_Mh=zeros(1,testCount);
Res_H=zeros(1,testCount);
% ��С֧�ֶȼ���
minSupCount=round(minSup*n);

%% ����ָ�������Ĳ��Լ�
for i=1:testCount
    [T,code]=produce_T(n,p,p1);
    % ��ÿ�����ݼ�����Apriori�㷨��
    [AFq,Acount]=Copy_of_cal_apriori(T,code);
    % ����Ȩֵ����ֵ
    [W,I]=newdiff(minSupCount,T,n,p);
    % ��ÿ�����ݼ���������Hopfield����
    [MFq,Mcount,~]=Copy_of_MHNN_main(T,code,W,I);
     % ��ÿ�����ݼ�����Hopfield����
    [HFq,Hcount,~]=Copy_of_HNN_main(T,code,W,I);
    % ���������㷨��������Ƶ���
     Apr_MaxFeq{i,1}=cell2mat(AFq);
     Mh_MaxFeq{i,1}=cell2mat(MFq);
     H_MaxFeq{i,1}=cell2mat(HFq);
     % ���������㷨�õ��Ĺ�������
     Res_Ap(1,i)=Acount;
     Res_Mh(1,i)=Mcount;
     Res_H(1,i)=Hcount;
end

% ��ý������
ac1=length(find((Res_Ap-Res_H)==0))/testCount;

ac2=length(find((Res_Ap-Res_Mh)==0))/testCount;








      

