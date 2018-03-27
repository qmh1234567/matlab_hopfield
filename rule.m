% 计算关联规则
function R=rule(T,F,S)
global nRules minCof
% 保存规则的数组
R=cell(nRules,4);
% 计数次数
k=1;
% 将支持度数组转化为字符串类型的
str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% 开始寻找关联规则
for i=1:size(F,2)
    % 找到不相交的集合
    S1 = deduct(S,F(i));
    %% 结合成关联规则
    for j=1:size(S1,1)   
        % 计算支持度 不考虑顺序
         % 求XY的支持度先对规则的顺序进行排列
         str_XY=num2str(perms([F(i) S1{j}]));
         % 在支持度集合中查找对应的支持度
         [~,lib]=ismember(str_XY,str_S);
         % 去掉矩阵中多余的0
         lib=lib(lib~=0);
         % 根据索引找到支持度
         Sup_XY=S{lib,2};
         % 计算置信度
         str_X=num2str(F(i));
         Conf_XY=confident(str_X,str_S,S,Sup_XY)
         % 生成规则
         % 置信度大于最小置信度才可以成为规则
         if Conf_XY>minCof
            R=form_rule(R,k,F(i),S1{j},Sup_XY,Conf_XY);
            k=k+1;
         end
         %% 如果Y>1，则还需要交换位置
          if size(S1{j},2)>1
               str_X1=num2str(S1{j});
               Conf_XY=confident(str_X1,str_S,S,Sup_XY)
              % 生成规则
              % 置信度大于最小置信度才可以成为规则
              if Conf_XY>minCof
                %k=k+1;
                R=form_rule(R,k,S1{j},F(i),Sup_XY,Conf_XY);
                k=k+1;
              end
          end
    end
end
% 将规则的多余列清除掉
R(k:end,:)=[];






