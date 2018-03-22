function [Rules,FreqItemsets] = findRules(T,minSup,minCof,nRules,sortFlag,code,rulefile)
% 参数说明：
% 输入  T:交易集合 每行代表一笔交易 每列代表一个物品种类
%       minSup最小支持度   minCof最小置信度 
%       nRules 最大规则数   sortFlag 是否按照支持度排序
%       code  编码规则  rulefile  保存规则
% 输出  Rules  2 x 1的元胞数组  Rules{1}{:}存放规则的左边 Rules{2}{:}存放规则的右边
%       FreqItemsets  保存各种大小的频繁项集

% 项目数
p = size(T,1);
% 交易数
n = size(T,2);
% 根据经验指定的相关变量
A = 550;
B = 100;
C = 200;
t = 1;
lambda =3;

step=0.0001;
% 网络的初始化 
U = randint(p,n);  % 生成一个p行n列的0 1随机矩阵
V = (1+tanh(lamda*U))/2;   % 根据神经元激活函数求单个神经元输出
iter_num =1000;  % 假设迭代次数为1000
E = zeros(1,iter_num);
% 寻优迭代
for k = 1:iter_num
    % 计算动态方程
    dU = diff_u(minSup,V,T);
    % 更新输入神经元状态
    U = U +dU*step;
    % 更新输出神经元状态
    V = (1+tanh(lamda*U))/2;
    % 计算能量函数
    e = energy(V,T);
    E(k)=e;
end
    


        

