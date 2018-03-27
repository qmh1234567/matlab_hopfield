function Sk = deduct(S,k)
% 首先找到含有某个数据的元组
% 对每一行判断是否含有k值，是则返回1，否则返回0
s1=cellfun(@(x) any(x(:)==k),S(:,1),'UniformOutput',false);
Sk=S;
% 再从元组中找到数值为1的索引
index=[];
for i=1:size(s1)
   if s1{i}==1
        index=[index;i];
    end
end
% 根据索引删除元组
Sk(index,:)=[];