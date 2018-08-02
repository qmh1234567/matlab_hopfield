%% 该脚本是用来评判两种网络性能的
% 测试集个数定义
function [ac1,ac2]=accurary(n,p,testCount)
% 神经网络的参数
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
% 最小支持度计数
minSupCount=round(minSup*n);

%% 生成指定数量的测试集
for i=1:testCount
    [T,code]=produce_T(n,p,p1);
    % 将每个数据集带入Apriori算法中
    [AFq,Acount]=Copy_of_cal_apriori(T,code);
    % 计算权值和阈值
    [W,I]=newdiff(minSupCount,T,n,p);
    % 将每个数据集带入忆阻Hopfield网络
    [MFq,Mcount,~]=Copy_of_MHNN_main(T,code,W,I);
     % 将每个数据集带入Hopfield网络
    [HFq,Hcount,~]=Copy_of_HNN_main(T,code,W,I);
    % 保存两种算法求出的最大频繁项集
     Apr_MaxFeq{i,1}=cell2mat(AFq);
     Mh_MaxFeq{i,1}=cell2mat(MFq);
     H_MaxFeq{i,1}=cell2mat(HFq);
     % 保存两种算法得到的关联规则
     Res_Ap(1,i)=Acount;
     Res_Mh(1,i)=Mcount;
     Res_H(1,i)=Hcount;
end

% 最好结果次数
ac1=length(find((Res_Ap-Res_H)==0))/testCount;

ac2=length(find((Res_Ap-Res_Mh)==0))/testCount;








      

