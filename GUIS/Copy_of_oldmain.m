%% 使用Hopfield网络挖掘关联规则
function [E Freq R]=Copy_of_oldmain(T,code1)
global A B C tao nRules minCof minSup 
code=code1;
% 最小支持度计数 取最接近的整数
n=size(T,1); % 交易次数
p=size(T,2); % 物品种类
minSupCount=round(minSup*n);

% 用户自定义最小支持度、最小置信度
minSup = 0.5;
minCof = 0.5;
nRules = 1000; % 最大规则数

% 根据经验指定的相关变量
A = 350;
B = 100;
C = 110;
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
[W,I]=newdiff(minSupCount,T,n,p);
x=real(fix(log10(max(max(abs(W)))))); %取权重的量级
dU = zeros(size(U)); %初始化为全0矩阵

% 决定步长和迭代次数
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=500;
end


% 进行迭代，找出频繁项集
 while k<Count
     % 计算du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % 从1行30列中提取5列出来 不能使用reshape，会改变数据的
                Row_M =W((a-1)*p+i,(b-1)*p+1:b*p);
                % V的每一行与Rom_w的每一行相乘
                sum_x = sum_x+ sum(V(b,:).*Row_M);
            end
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);
        end
    end
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
     e = energy(minSupCount,V,T,n,p)
     E(k)=e;
     k=k+1
 end

%% 结果输出  能量函数曲线、最大频繁项集、关联规则
% 清除能量函数矩阵多余的列
E(k:end)=[];
% 绘制能量函数图
% figure;
% plot(E)
% xlabel('迭代次数')
% ylabel('能量函数')
% title('能量函数变化曲线')


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
Freq = code(F)

% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度
S = support(T,F);
% 计算关联规则 1是按照支持度排序  2是按照置信度排序  0代表oldmain  1代表main
R=rule(T,F,S,1,0,code);

    

             