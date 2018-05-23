%% 使用Apriori算法挖掘关联规则
function [Max_Req,Rcount]=cal_apriori(transactions,code)
% 参数初始化
% inputfile = 'mygoods.txt';
% 需要根据交易人数来修改最小支持度
minSup = 0.5; % 最小支持度
minCof = 0.5; % 最小置信度
nRules = 1000; % 输出最大规则数
sortFlag = 1; % 按照支持度排序


%% 调用Apriori关联规则算法，自定义函数
[Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code);

% 返回最大频繁项集
Max_Req=[];
for i=2:size(FreqItemsets,2)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
        Max_Req=[Max_Req code(matrix(j,:))];
    end
end
Max_Req=unique(Max_Req);


Rcount=size(Rules{1},1); % 返回关联规则条数

disp('Apriori算法挖掘菜品订单关联规则完成');