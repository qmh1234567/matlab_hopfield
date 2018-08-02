% 计算频繁项集的支持度
function Sup = support(T,F,minSup)
nRules = 1000;
% 保存支持度的数组
Sup = cell(nRules,2);
% 事务的个数
D = size(T,1);
% 计数次数
iter_num=1;
for k=1:length(F)
    % 返回F中取k项的组合
    R = nchoosek(F,k);
    % 计数初始化
   for r=1:size(R,1)
       % 计算每个子项集
       SubF = T(:,R(r,:));
       % 如果频繁项集大小大于1，计算一起出现的次数
       count=0; % 计数初始化
       for t=1:size(SubF,1)
          sub_c=SubF(t,:);
          res = isequal(sub_c,ones(size(sub_c)));
           if res==1
                count=count+1;
           end
       end
       % 计算每个子频繁项集的支持度
       s = count/D;
       if s>=minSup     
            % 保存子频繁项集
            Sup{iter_num,1}=R(r,:);
            % 保存支持度
            Sup{iter_num,2}=[[];s];
            % 计数+1
            iter_num=iter_num+1;
       end
   end
end
% 将多余的行置空，避免占用空间
Sup(iter_num:end,:)=[];

