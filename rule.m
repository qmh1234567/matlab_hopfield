% 计算关联规则
function R=rule(T,F,S,sortFlag)
global nRules minCof
% 保存规则的数组
R=cell(nRules,4);
% 计数次数
k=1;
% 将支持度数组转化为字符串类型的
str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% 开始寻找关联规则
for i=1:size(S,1)
    % 取出每一行，找到与该行不相交的集合
    Sub_S =S{i,:};
    S1 = deduct(S,Sub_S);
    % 组合生成关联规则
    for j=1:size(S1,1)
        % 计算支持度 不考虑顺序
        % 求XY的支持度先对规则的顺序进行排列
        str_XY=num2str(perms([Sub_S S1{j}]));
        % 在支持度集合中查找对应的支持度
        [~,lib]=ismember(str_XY,str_S);
        % 去掉矩阵中多余的0
        lib=lib(lib~=0);
        if isempty(lib)
            continue;
        end
        % 根据索引找到支持度
        Sup_XY=S{lib,2};
        % 计算置信度
        str_X=num2str(Sub_S);
        Conf_XY=confident(str_X,str_S,S,Sup_XY);
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






