%% 使用Hopfield网络挖掘关联规则
clear;
global A B C tao
% 参数初始化
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % 输出转化后的01矩阵
rulesfile = 'rules.txt'; % 输出关联规则
% 用户自定义最小支持度、最小置信度
minSup = 2;
minCof = 0.5;
nRules = 100; % 最大规则数
% 调用编码函数，将交易集转化为01矩阵
[transaction,code] = trans2matrix(inputfile,outputfile,' ')
T = transaction;
% 项目数
p = size(T,1);
% 交易数
n = size(T,2);
% 根据经验指定的相关变量
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;
step=0.0001;
% 生成区间为0-1，p*n的矩阵
U = randi([0,1],p,n);
disp('第一次的U')
disp(U)
V =(1+tanh(lambda*U))/2;
iter_num = 5; %迭代次数
E = zeros(1,iter_num);

for k = 1:iter_num
    % 计算动态方程
    dU=diff_u(U,minSup,V,T);
    % 更新输入神经元
    U= U+dU*step;
    % 更新输出神经元
    disp('中间的V')
    V = (1+tanh(lambda*U))/2
    % 计算能量函数
    e = energy(minSup,V,T);
end

disp('最后的V')
disp(V)
% 返回最大元素 和最大元素在A中的行索引
%[rows,cols]=size(V);
%V1=zeros(rows,cols);
%[V_max,V_ind]=max(V);
%for j=1:cols
%    V1(V_ind(j),j)=1;
%end
%disp(V1)
             


