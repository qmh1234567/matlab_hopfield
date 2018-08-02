function [T,code]=produce_T(n,p,p1)

% 产生随机交易矩阵
% T= randi([0,1],n,p)>(1-p1);
% T(find(T==2))=1; % 将1的概率变多一些
T=zeros(n,p);
idx=randperm(n*p);
index=p1*(n*p);
T(idx(1:index))=1;



% 编码库  大概有30类物品
MyCodes={'奶酪','糖果','足球','衣服','靴子','鸡肉','洗面奶','沐浴露','洗发水','梳子','镜子','电池','发夹','戒指','胸针','复印机','耳机','字典','充电器','围巾','领带','西服','饮水机','台球','指南针','毛巾','热水瓶','水杯','鼠标','卫生纸'};
Total_num=length(MyCodes);
% 产生编码规则矩阵 randperm(N,K) 产生1-N的不重复的数，K个
code=MyCodes(randperm(Total_num,p));

