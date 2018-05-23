%% 该脚本是用来评判两种网络性能的
% 测试集个数定义
clc;
clear;
testCount=100;
% 元胞数组保存所有的交易集
% MyT=cell(testCount,1);  
% Mycode=cell(testCount,1);
% 神经网络的参数
n=8;
p=8;
p1=0.5; % 1出现的概率
minSup = 0.5;
% Apriori算法 忆阻Hopfield网络 hopfield网络的最大频繁项集
Apr_MaxFeq=cell(testCount,1);
Mh_MaxFeq=cell(testCount,1);
H_MaxFeq=cell(testCount,1);
% 保存Apriori算法 忆阻Hopfield网络 Hopfield网络 的规则数
Res_Ap=zeros(1,testCount);
Res_Mh=zeros(1,testCount);
Res_H=zeros(1,testCount);
% 保存两种网络能量函数的最小收敛次数
E_M=zeros(1,testCount);
E_H=zeros(1,testCount);
minSupCount=round(minSup*n);
%% 生成指定数量的测试集
for i=1:testCount
    [T,code]=produce_T(n,p,p1);
%     MyT{i,1}=T;
%     Mycode{i,1}=code;
    % 将每个数据集带入Apriori算法中
    [AFq,Acount]=cal_apriori(T,code);
    % 计算权值和阈值
    [W,I]=newdiff(minSupCount,T);
    % 将每个数据集带入忆阻Hopfield网络
    [MFq,Mcount,MEcount]=Copy_of_main(T,code,W,I);
     % 将每个数据集带入Hopfield网络
    [HFq,Hcount,MHcount]=Copy_of_oldmain(T,code,W,I);
    % 保存两种算法求出的最大频繁项集
     Apr_MaxFeq{i,1}=cell2mat(AFq);
     Mh_MaxFeq{i,1}=cell2mat(MFq);
     % 保存两种算法得到的关联规则
     Res_Ap(1,i)=Acount;
     Res_Mh(1,i)=Mcount;
     Res_H(1,i)=Hcount;
     % 保存能量函数的最小收敛次数
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
title('三种算法关联规则条数比较')
legend('Apriori','HNN','MHNN');
xlabel('迭代次数')
ylabel('关联规则条数')


figure(4);
plot(x,E_M,'r');
hold on 
plot(x,E_H,'b');
title('两种网络能量函数收敛次数比较')
legend('MHNN','HNN');
xlabel('迭代次数')
ylabel('能量函数收敛次数')



% 最好结果次数
L1=length(find((Res_Ap-Res_H)==0))

L2=length(find((Res_Ap-Res_Mh)==0))

% 能量函数平均收敛次数
Count_H=sum(E_H)/length(E_H)

Count_MH=sum(E_M)/length(E_M)





      

