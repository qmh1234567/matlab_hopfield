%% 使用Hopfield网络挖掘关联规则
clear;
global A B C tao n p nRules minCof
% 参数初始化
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % 输出转化后的01矩阵
rulesfile = 'rules.txt'; % 输出关联规则
% 用户自定义最小支持度、最小置信度
minSup = 2;
minCof = 0.5;
nRules = 100; % 最大规则数
% 调用编码函数，将交易集转化为01矩阵
[T,code] = trans2matrix(inputfile,outputfile,' ')
% 项目数
n = size(T,1);
% 交易数
p = size(T,2);
% 根据经验指定的相关变量
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;
step=0.0001; % 不宜过大
% 生成区间为0-1，p*n的矩阵
%U = T;
U = randi([0,1],n,p);
disp('第一次的U')
disp(U)
V =(1+tanh(lambda*U))/2;
% 保存能量函数值的矩阵
E = zeros(1,100);
k=1;
while k<5
    % 计算动态方程
    dU=diff_u(U,minSup,V,T)
    % 更新输入神经元
    U= U+dU*step;
    % 更新输出神经元
    disp('中间的V')
    V = (1+tanh(lambda*U))/2
    % 计算能量函数
    e = energy(minSup,V,T);
    E(k)=e;
    k=k+1
end
% 最大频繁项集
Frequent=int8(V)
[~,index]=find(Frequent==1);
F = unique(index');
disp('最大频繁项集为:')
code(F)
% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度
S = support(T,F);
% 计算关联规则
R=rule(T,F,S);


             