function Conf_XY=confident(str_X,str_S,S,Sup_XY)
 % 在支持度集合中查找对应的支持度
[~,libx]=ismember(str_X,str_S);
% 根据索引找到X的支持度
Sup_X=S{libx,2};
% 计算置信度
Conf_XY=Sup_XY/Sup_X;