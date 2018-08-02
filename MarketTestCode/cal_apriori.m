%% 使用Apriori算法挖掘关联规则
clc;
clear;
% 参数初始化
inputfile = 'test1.txt';
outputfile = 'as.txt'; % 输出转换后 0 1矩阵文件
% 需要根据交易人数来修改最小支持度
minSup = 0.01; % 最小支持度
minCof = 0.1; % 最小置信度
nRules = 1000; % 输出最大规则数
sortFlag = 1; % 按照支持度排序
rulefile = 'rules.txt'; % 规则输出文件
Rcount=zeros(1,1000);
minRow=1;
k=1;
%% 调用转换程序,把数据转换为0 1 矩阵  自定义函数
while minRow<1000 
    [transactions,code] = trans2matrix(inputfile,outputfile,' ',minRow);
    minRow=minRow+20;
    %% 调用Apriori关联规则算法，自定义函数
    [Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code,rulefile);
    disp('Apriori算法挖掘菜品订单关联规则完成');
    Rcount(1,k)=size(Rules{1},1);
    k=k+1;
end
plot(Rcount)