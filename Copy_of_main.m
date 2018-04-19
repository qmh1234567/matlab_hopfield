%% 使用Hopfield网络挖掘关联规则
clear;
global A B C tao n p nRules minCof minSup
% 参数初始化
inputfile = 't.txt';
outputfile= 'as.txt'; % 输出转化后的01矩阵
rulesfile = 'rules.txt'; % 输出关联规则
% 用户自定义最小支持度、最小置信度
minSup = 0.5;
minCof = 0.5;
nRules = 100; % 最大规则数
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
step=0.000001; % 不宜过大

R =2000; % 与忆阻器串联的电阻

% 生成区间为0-1，p*n的矩阵
% U = T;
U = randi([0,1],n,p);
disp('第一次的U')
disp(U)
V =(1+tanh(lambda*U))/2;
% 保存能量函数值的矩阵
E = zeros(1,1000);
k=1; %迭代次数 取1000
% 计算出权值和阈值
[W,I]=newdiff(minSupCount,T);
% M=2000./W-2000;
% M(M==inf)=0;
% Wm=1./M;
% Wm(Wm==inf)=0;
% % 
% I=I./100;
% Iv=0.6*(n*p+2)-I;
% Iv=Iv.*100;

% 归一化矩阵
W1=mapminmax(W,0,1);

% M=2000./W1-2000;
% M(M==inf)=0;
% M1=2000./M;
% for i=1:size(M,1)
%     M(i,i)=0;
% end

dU = zeros(size(U)); %初始化为全0矩阵
 while k<100
     % 计算du
    for a=1:n
        for i=1:p
            sum_x = 0;
            for b=1:n
                % 从1行30列中提取5列出来 不能使用reshape，会改变数据的
                Row_M =W1((a-1)*p+i,(b-1)*p+1:b*p);
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
     % 计算能量函数
     e = energy(minSupCount,V,T)
     E(k)=e;
     k=k+1
end

% 清除能量函数矩阵多余的列
E(k:end)=[];
% 绘制能量函数图
plot(E)
xlabel('迭代次数')
ylabel('能量函数')
title('能量函数变化曲线')
% 最大频繁项集
Frequent=int8(V);
[~,index]=find(Frequent==1);
F = unique(index');
disp('最大频繁项集为:')
code(F)
% 根据最大频繁项集生成关联规则
% 计算每个子项集的支持度
S = support(T,F);
% 计算关联规则 1是按照支持度排序  2是按照置信度排序
R=rule(T,F,S,1);
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
disp(['存储规则到文件' rulesfile '完成' '规则数为' num2str(size(R,1)) '条'])
    

             