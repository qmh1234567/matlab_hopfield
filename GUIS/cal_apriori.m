%% 使用Apriori算法挖掘关联规则
function [Rules FreqItemsets code]=cal_apriori(inputfile)
% 参数初始化
% inputfile = 'mygoods.txt';
outputfile = 'as.txt'; % 输出转换后 0 1矩阵文件
% 需要根据交易人数来修改最小支持度
minSup = 0.5; % 最小支持度
minCof = 0.5; % 最小置信度
nRules = 1000; % 输出最大规则数
sortFlag = 1; % 按照支持度排序
rulefile = 'Aprirules.txt'; % 规则输出文件

%% 调用转换程序,把数据转换为0 1 矩阵  自定义函数
[transactions,code] = trans2matrix(inputfile,outputfile,' ');


%% 调用Apriori关联规则算法，自定义函数
[Rules,FreqItemsets] = findRules(transactions,minSup,minCof,nRules,sortFlag,code,rulefile);

disp('Apriori算法挖掘菜品订单关联规则完成');