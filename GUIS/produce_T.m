function [T code]=produce_T(n,p)
% 产生随机交易矩阵
T= randi([0,1],n,p);
% 编码库  大概有30类物品
MyCodes={'奶酪','糖果','足球','衣服','靴子','鸡肉','洗面奶','沐浴露','洗发水','梳子','镜子','电池','发夹','戒指','胸针','复印机','耳机','字典','充电器','围巾','领带','西服','饮水机','台球','指南针','毛巾','热水瓶','水杯','鼠标','卫生纸'};
Total_num=length(MyCodes);
% 产生编码规则矩阵 randperm(N,K) 产生1-N的不重复的数，K个
code=MyCodes(randperm(Total_num,p));

% 生成购物清单txt
fid=fopen('mygoods.txt','w');
for i=1:size(T,1)
    % 获得元素为1的列下标
    [~,ib]=find(T(i,:)==1);
    % 进行编码 将cell数组转化为字符数组
    code1=code(ib);
    % 因为不同的cell之间不会有空格，需要手动添加
    code2=cellfun(@(u)[u,' '],code1(1:end),'UniformOutput',false);
    str_arry=cell2mat(code2);
    % 写入文件
    fprintf(fid,'%s\n',str_arry);
end
fclose(fid);
disp(['生成购物清单到''mygoods.txt' '完成!']);

% 生成交易集T的txt
fid1=fopen('Tvalue.txt','w');
for i=1:size(T,1)
    fprintf(fid1,'%s\n',num2str(T(i,:)));
end
fclose(fid);
disp(['生成交易集T到' 'Tvalue.txt' '完成!']);