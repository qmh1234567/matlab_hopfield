function Conf_XY=confident(str_X,str_S,S,Sup_XY)
 % ��֧�ֶȼ����в��Ҷ�Ӧ��֧�ֶ�
[~,libx]=ismember(str_X,str_S);
% ���������ҵ�X��֧�ֶ�
Sup_X=S{libx,2};
% �������Ŷ�
Conf_XY=Sup_XY/Sup_X;