%% 计算关联规则
function R=rule(S,sortFlag,mainFlag)
global nRules minCof
if mainFlag==0
    rulesfile='oldrules.txt';
elseif mainFlag==1
    rulesfile = 'rules.txt'; % 输出关联规则
else
    rulesfile='CMrules.txt';
end
% 保存规则的数组
R=cell(nRules,4);
% 计数次数
k=1;
% % 将支持度数组转化为字符串类型的
% str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% 开始寻找关联规则
for i=1:size(S,1)
    % 取出每一行，找到与该行不相交的集合
    Sub_S =S{i,:};
    S1 = deduct(S,Sub_S);
    % 组合生成关联规则
    for j=1:size(S1,1)
        % 计算支持度 不考虑顺序
        % 求XY的支持度先对规则的顺序进行排列
        XY=perms([Sub_S S1{j}]);
        % 在支持度集合中查找对应的支持度
         for t=1:size(XY,1)
            lib=cellfun(@(x)isequal(x,XY(t,:)),S(:,1));
            if any(lib)~=0
                break;
            end
         end
        % 找到1所对应的索引
        lib=find(lib==1);
        if isempty(lib)
            continue;
        end
        % 根据索引找到支持度
        Sup_XY=S{lib,2};
        % 计算置信度
        str_X=Sub_S;
        Conf_XY=confident(str_X,S,Sup_XY);
        % 生成规则
        % 置信度大于最小置信度才可以称为规则
        if Conf_XY>minCof
            R=form_rule(R,k,Sub_S,S1{j},Sup_XY,Conf_XY);
            k=k+1;
        end
    end
end        
% 将规则的多余列清除掉
R(k:end,:)=[];
% 对规则进行排序
switch sortFlag
   case 1
        R=sortrows(R,-3);
    case 2
        R=sortrows(R,-4);
end
% 将规则写入文件
ShowRule(rulesfile,R);



function Conf_XY=confident(X,S,Sup_XY)
 % 在支持度集合中查找对应的支持度
lib=cellfun(@(x)isequal(x,X),S(:,1));
% 找到1所对应的索引
libx=find(lib==1);
% 根据索引找到X的支持度
Sup_X=S{libx,2};
% 计算置信度
Conf_XY=Sup_XY/Sup_X;


function R=form_rule(R,k,X,Y,Sup_XY,Conf_XY)
% 规则的X
R{k,1}=X;
% 规则的Y
R{k,2}=Y;
% 支持度填入规则的第三列
R{k,3}=Sup_XY;
% 置信度填入规则的第4列
R{k,4}=Conf_XY;


function Sk = deduct(S,Sub_S)
% 在S集合中找到与Sub_S不相交的集合
for i=1:size(Sub_S,2)
    % 先取出该行中每一个数据
      k=Sub_S(1,i);
    % 对S的每一行判断这些数据在S中是否存在，是则返回1，否则返回0
      s1=cellfun(@(x) any(x(:)==k),S(:,1),'UniformOutput',false);
      % 将cell转化为logical型矩阵
      mat_s1=cell2mat(s1);
     % 从矩阵中找到数组为1的索引
      [index,~]=find(mat_s1==1);
      % 根据索引删除数组
      S(index,:)=[];
end
Sk=S;

function ShowRule(rulesfile,R)
global code
% 将关联规则输出到txt中
fid=fopen(rulesfile,'w');
fprintf(fid,'%s (%s,%s) \n','Rule','Support','Confidence');
for i=1:size(R,1)
    s1 ='';
    s2 ='';
    for j = 1:size(R{i,1},2)
        if j == size(R{i,1},2)
            s1= [s1 code{R{i,1}(j)}];
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








