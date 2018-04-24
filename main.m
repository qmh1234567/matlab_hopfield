%% 使用Hopfield网络挖掘关联规则
clc;
clear;
global A B C tao n p nRules minCof minSup code
%% 参数初始化
inputfile = 'GUIS\mygoods.txt';
outputfile= 'as.txt'; % 输出转化后的01矩阵
% 用户自定义最小支持度、最小置信度
minSup = 0.5;
minCof = 0.5;
nRules = 1000; % 最大规则数

% 调用编码函数，将交易集转化为01矩阵
[T,code] = trans2matrix(inputfile,outputfile,' ')
% 项目数
n = size(T,1);
% 最小支持度计数 取最接近的整数
minSupCount=round(minSup*n);
% 交易数
p = size(T,2);

% 根据经验指定的相关变量
A = 550;
B = 100;
C = 200;
tao = 1;
lambda =3;

% U初始化为T
U = T;
disp('第一次的U')
disp(U)
V =(1+tanh(lambda*U))/2;
% 保存能量函数值的矩阵
E = zeros(1,1000);
k=1; %迭代次数 

%% 计算最大频繁项集
% 计算出权值和阈值
[W,I]=newdiff(minSupCount,T);

% 映射到忆阻值矩阵
% M=W+100; % 用忆阻值代替权值  增加了100
Iv=I./100; % 阈值电流     

% 将权重映射到忆阻值
M2=W./(max(max(abs(W)))+10); % 归一化
x=real(fix(log10(max(max(abs(W)))))); %取权重的量级
M1=M2*10^x+10^(x-2); % 可减少迭代次数，并保证结果的准确性
dU = zeros(size(U)); %初始化为全0矩阵

% 决定步长
if x>4
    step=10^(-(x+3));
else
    step=10^(-(x+2));
end


% 进行迭代，找出频繁项集
 while k<500
     % 计算du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % 从1行30列中提取5列出来 不能使用reshape，会改变数据的
                Row_M =M1((a-1)*p+i,(b-1)*p+1:b*p);
                % V的每一行与Rom_w的每一行相乘
                sum_x = sum_x+ sum(V(b,:).*Row_M);
            end
            if x>4
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-2);
            else
             dU(a,i)=-U(a,i)/tao+sum_x+Iv(a,i)*100*10^(x-3);  
            end
        end
    end
    dU
     % 更新输入神经元
     U= U+dU*step
     % 更新输出神经元
     disp('中间的V')
     V = (1+tanh(lambda*U))/2
     % 如果输出矩阵全0，说明找不到频繁2项集的，就提前退出
     if any(any(V))==0
         break;
     end
     % 计算能量函数
     e = energy(minSupCount,V,T)
     E(k)=e;
     k=k+1
 end

%% 结果输出  能量函数曲线、最大频繁项集、关联规则
% 清除能量函数矩阵多余的列
E(k:end)=[];
% 绘制能量函数图
plot(E)
xlabel('迭代次数')
ylabel('能量函数')
title('能量函数变化曲线')

% 最大频繁项集
Frequent=int8(V);
index=[];
% 只需要全1的列，或者趋近于1的列
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index=[index;i];
     end
end
F = unique(index')
disp('最大频繁项集为:')
code(F)

% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度
S = support(T,F);
% 计算关联规则 1是按照支持度排序  2是按照置信度排序
R=rule(T,F,S,1);

    

             