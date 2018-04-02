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

