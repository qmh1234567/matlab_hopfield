%% �ýű����������������������ܵ�
% ���Լ���������
clc;
clear;
testCount=100;
% Ԫ�����鱣�����еĽ��׼�
% MyT=cell(testCount,1);  
% Mycode=cell(testCount,1);
% ������Ĳ���
n=8;
p=8;
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
% ������������������������С��������
E_M=zeros(1,testCount);
E_H=zeros(1,testCount);
minSupCount=round(minSup*n);
%% ����ָ�������Ĳ��Լ�
for i=1:testCount
    [T,code]=produce_T(n,p,p1);
%     MyT{i,1}=T;
%     Mycode{i,1}=code;
    % ��ÿ�����ݼ�����Apriori�㷨��
    [AFq,Acount]=cal_apriori(T,code);
    % ����Ȩֵ����ֵ
    [W,I]=newdiff(minSupCount,T);
    % ��ÿ�����ݼ���������Hopfield����
    [MFq,Mcount,MEcount]=Copy_of_main(T,code,W,I);
     % ��ÿ�����ݼ�����Hopfield����
    [HFq,Hcount,MHcount]=Copy_of_oldmain(T,code,W,I);
    % ���������㷨��������Ƶ���
     Apr_MaxFeq{i,1}=cell2mat(AFq);
     Mh_MaxFeq{i,1}=cell2mat(MFq);
     % ���������㷨�õ��Ĺ�������
     Res_Ap(1,i)=Acount;
     Res_Mh(1,i)=Mcount;
     Res_H(1,i)=Hcount;
     % ����������������С��������
     E_M(1,i)=MEcount;
     E_H(1,i)=MHcount;
end

x=1:1:testCount;
figure(3);
plot(x,Res_Ap,'-.go');
hold on
plot(x,Res_H,'--b+');
hold on 
plot(x,Res_Mh,':rp');
title('�����㷨�������������Ƚ�')
legend('Apriori','HNN','MHNN');
xlabel('��������')
ylabel('������������')


figure(4);
plot(x,E_M,'r');
hold on 
plot(x,E_H,'b');
title('�������������������������Ƚ�')
legend('MHNN','HNN');
xlabel('��������')
ylabel('����������������')



% ��ý������
L1=length(find((Res_Ap-Res_H)==0))

L2=length(find((Res_Ap-Res_Mh)==0))

% ��������ƽ����������
Count_H=sum(E_H)/length(E_H)

Count_MH=sum(E_M)/length(E_M)





      

