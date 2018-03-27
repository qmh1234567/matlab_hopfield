function R=form_rule(R,k,X,Y,Sup_XY,Conf_XY)
% 规则的X
R{k,1}=X;
% 规则的Y
R{k,2}=Y;
% 支持度填入规则的第三列
R{k,3}=Sup_XY;
% 置信度填入规则的第4列
R{k,4}=Conf_XY;