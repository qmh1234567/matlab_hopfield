%% 使用Hopfield网络挖掘关联规则
function [Freq,Rcount,Ecount]=Copy_of_HNN_main(T,code,W,I)
% 用户自定义最小支持度、最小置信度
minSup = 0.5;
minCof = 0.5;
% 根据经验指定的相关变量
tao = 1;
lambda =3;
%% 生成交易集
%% 参数初始化
% inputfile = 'test1.txt';
% outputfile= 'as.txt'; % 输出转化后的01矩阵
% % 调用编码函数，将交易集转化为01矩阵
% [T,code]= trans2matrix(inputfile,outputfile,' ');
% % 项目数
n = size(T,1);
% 最小支持度计数 取最接近的整数
minSupCount=round(minSup*n);
% % 交易数
p = size(T,2);
% U初始化为T
U = T;
disp('第一次的U')
disp(U)
V =(1+tanh(lambda*U))/2;
% 保存能量函数值的矩阵
E = zeros(1,1000);

%% 计算最大频繁项集
N=n*p;
% 计算出权值和阈值
% [W,I]=newdiff(minSupCount,T,n,p);
%% 对权重矩阵进行处理
% 遍历元胞数组求出权重矩阵的最大值
MaxValue=1;
for i=1:N
    newMaxValue=max(abs(W{i}));
    if MaxValue<newMaxValue
        MaxValue=newMaxValue;
    end
end
% 取权重最大值的量级
x=real(fix(log10(MaxValue)));
%% 计算迭代次数和步长
% 决定步长
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=500;
end
%% 找出最大频繁项集
dU = zeros(size(U)); %初始化为全0矩阵
% 进行迭代，找出频繁项集
k=1;%迭代次数
 while k<Count
     m=1;% 权重矩阵的索引初始化
     % 计算du
    for a=1:n
        for i=1:p
            sum_x = W{m}*reshape(V',[N,1]);%将原来n行p列的输出矩阵重构为N行1列
            if x>4
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);
            else
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);  
            end
            m=m+1;
        end
    end
     % 更新输入神经元
     U= U+dU*step;
     V = (1+tanh(lambda*U))/2;
     % 如果输出矩阵全0，说明找不到频繁2项集的，就提前退出
     if any(any(V))==0
         break;
     end
     % 计算能量函数
    e = energy(minSupCount,V,T,n,p);
    E(k)=e;
    k=k+1;
 end

%% 结果输出  能量函数曲线、最大频繁项集、关联规则
% 清除能量函数矩阵多余的列
E(k:end)=[];
% % 绘制能量函数图
% plot(E)
% xlabel('迭代次数')
% ylabel('能量函数')
% title('能量函数变化曲线')
Ecount=0;
% 找到收敛稳定的最小的次数
for i=size(E,2):-1:1
    if(abs(abs(E(i))-abs(E(end)))>500)
        Ecount=i;
        break;
    end
end

% 输出最大频繁项集
Frequent=int8(V);
index=zeros(1,size(Frequent,2));
k=1;
% 只需要全1的列，或者趋近于1的列
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index(k)=i;
         k=k+1;
     end
end
index(k:end)=[];
F = unique(index');
disp('最大频繁项集为:')
Freq = code(F);

% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度  支持度为0.3
S = support(T,F,minSup);
% 计算关联规则 1是按照支持度排序  2是按照置信度排序,0是main  1是copyofmain,置信度为0.3
R=rule(S,1,1,minCof,code);
Rcount=size(R,1);

    

                