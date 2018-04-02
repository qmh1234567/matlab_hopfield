%% 使用Hopfield网络挖掘关联规则
clear;
global A B C tao n p nRules minCof minSup
% 参数初始化
inputfile = 'test_i.txt';
outputfile= 'as.txt'; % 输出转化后的01矩阵
rulesfile = 'rules.txt'; % 输出关联规则
% 用户自定义最小支持度、最小置信度
minSup = 0.3;
minCof = 0.5;
nRules = 100; % 最大规则数
% 调用编码函数，将交易集转化为01矩阵
[T,code] = trans2matrix(inputfile,outputfile,' ')
% 项目数
n = size(T,1);
% 最小支持度计数 向上取整
minSupCount=ceil(minSup*n);
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
V =(1+tansig(lambda*U))/2;
% 保存能量函数值的矩阵
E = zeros(1,100);
k=1;
e=1;
while k<100
    % 计算动态方程
    dU=diff_u(U,minSupCount,V,T)
    % 更新输入神经元
    U= U+dU*step
    % 更新输出神经元
    disp('中间的V')
    V = (1+tanh(lambda*U))/2
    % 计算能量函数
    e = energy(minSupCount,V,T)
    E(k)=e;
    k=k+1
end
% 最大频繁项集
%Frequent=int8(V)
Frequent=V;
[~,index]=find(Frequent==1);
F = unique(index');
disp('最大频繁项集为:')
code(F)
% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度
S = support(T,F);
% 计算关联规则
R=rule(T,F,S);
% 将关联规则输出到txt中
fid=fopen(rulesfile,'w');
fprintf(fid,'%s (%s,%s) \n','Rule','Support','Confidence');
for i=1:size(R,1)
    s1 = '';
    s2 = '';
    for j = 1:size(R{i,1},2)
        if j == size(R{i,1},2)
            s1 = [s1 code{R{i,1}(j)}];
        else
            s1 = [s1 code{R{i,1}(j)} ' '];
        end
    end
    %s1=cell2mat(code(R{i,1}));
    for j = 1:size(R{i,2},2)
        if j == size(R{i,2},2)
            s2 = [s2 code{R{i,2}(j)}];
        else
            s2 = [s2 code{R{i,2}(j)} ' '];
        end
    end
    %s2=cell2mat(code(R{i,2}));
    s3=num2str(R{i,3}*100);
    s4=num2str(R{i,4}*100);
    fprintf(fid,'%s -> %s (%s%%,%s%%)\n',s1,s2,s3,s4);
end
fclose(fid);
disp(['存储规则到文件' rulesfile '完成'])
    

             