% 计算频繁项集的支持度
function Sup = support(T,F)
global nRules
% 保存支持度的数组
Sup = cell(nRules,2);
% 事务的个数
D = size(T,1);
% 计数次数
t=1;
for k=1:length(F)
    % 返回F中取k项的组合
    R = nchoosek(F,k);
   for r=1:size(R,1)
       % 计算每个子项集
       SubF = T(:,R(r,:));
       % 如果频繁项集大小大于1，计算一起出现的次数
       if size(SubF)>1
           count=length(SubF)-length(unique(SubF));
       else
           count=sum(SubF); % 频繁1项集
       end
       % 计算每个子频繁项集的支持度
       s = count/D;
       % 保存子频繁项集
       Sup{t,1}=R(r,:);
       % 保存支持度
       Sup{t,2}=[[];s];
       % 计数+1
       t=t+1;
   end
end
% 将多余的行置空，避免占用空间
Sup(t:end,:)=[];


