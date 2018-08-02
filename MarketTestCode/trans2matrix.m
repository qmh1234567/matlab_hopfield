function[output,code]=trans2matrix(inputfile,outputfile,splitter,minRow)
%% 把输入事务转化为0 1矩阵，每行代表一个事务
% 输入参数
% inputfile :输入文件，空格分隔每个项目
% outputfile: 输出文件，转换后的0，1矩阵文件
% splitter:输入文件的间隔符，默认为空格
% 输出参数
% output:转化后的0，1矩阵   code 编码规则

if nargin<3 % 函数输入参数数目
    splitter=' ';
end

%% 读入文件 获取编码规则
fid = fopen(inputfile);
tline = fgetl(fid);  % 读取文件中的每一行，并去掉换行符
lines = 1;
code={};
MaxRow=minRow+19;
while ischar(tline)
    disp(tline)
    if lines<MaxRow
        lines=lines+1; % 记录行数
        tline = fgetl(fid);
        if lines>=minRow
            tline= deblank(tline); % 去掉首尾多余的空格
            tline = regexp(tline,splitter,'split'); % 匹配正则表达式，在分隔符处拆分文本
            code =[code tline]; %合并
            code = unique(code); %去除重复记录
            tline = fgetl(fid);
        end
    else
        break;
    end
end

disp('编码规则为：')
disp(num2str(1:size(code,2)))
disp(code);
fclose(fid); % 关闭文档

% 读取文件，根据编码规则对原始数据进行转化
itemsnum = size(code,2); % 取单元数组中的列

output = zeros(lines,itemsnum);

fid = fopen(inputfile);
tline = fgetl(fid);
lines = 0;
while ischar(tline)
    if lines<20
        lines=lines+1; %记录行数
        tline=deblank(tline);
        tline=regexp(tline,splitter,'split');
        [~,icode,~] = intersect(code,tline);% 寻找下标
        output(lines,icode)=1;
        tline=fgetl(fid);
    else
        break;
    end
end
fclose(fid);

%% 把转换后的矩阵写入文件
fid = fopen(outputfile,'w');
for i=1:lines
    fprintf(fid,'%s\n',num2str(output(i,:)));
end
fclose(fid);
end


