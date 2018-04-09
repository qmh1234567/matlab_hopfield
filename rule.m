% �����������
function R=rule(T,F,S,sortFlag)
global nRules minCof
% ������������
R=cell(nRules,4);
% ��������
k=1;
% ��֧�ֶ�����ת��Ϊ�ַ������͵�
str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% ��ʼѰ�ҹ�������
for i=1:size(S,1)
    % ȡ��ÿһ�У��ҵ�����в��ཻ�ļ���
    Sub_S =S{i,:};
    S1 = deduct(S,Sub_S);
    % ������ɹ�������
    for j=1:size(S1,1)
        % ����֧�ֶ� ������˳��
        % ��XY��֧�ֶ��ȶԹ����˳���������
        str_XY=num2str(perms([Sub_S S1{j}]));
        % ��֧�ֶȼ����в��Ҷ�Ӧ��֧�ֶ�
        [~,lib]=ismember(str_XY,str_S);
        % ȥ�������ж����0
        lib=lib(lib~=0);
        if isempty(lib)
            continue;
        end
        % ���������ҵ�֧�ֶ�
        Sup_XY=S{lib,2};
        % �������Ŷ�
        str_X=num2str(Sub_S);
        Conf_XY=confident(str_X,str_S,S,Sup_XY);
        % ���ɹ���
        % ���Ŷȴ�����С���ŶȲſ��Գ�Ϊ����
        if Conf_XY>minCof
            R=form_rule(R,k,Sub_S,S1{j},Sup_XY,Conf_XY);
            k=k+1;
        end
    end
end        
% ������Ķ����������
R(k:end,:)=[];
% �Թ����������
switch sortFlag
   case 1
        R=sortrows(R,-3);
    case 2
        R=sortrows(R,-4);
end






