% �����������
function R=rule(T,F,S)
global nRules minCof
% ������������
R=cell(nRules,4);
% ��������
k=1;
% ��֧�ֶ�����ת��Ϊ�ַ������͵�
str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% ��ʼѰ�ҹ�������
for i=1:size(F,2)
    % �ҵ����ཻ�ļ���
    S1 = deduct(S,F(i));
    %% ��ϳɹ�������
    for j=1:size(S1,1)   
        % ����֧�ֶ� ������˳��
         % ��XY��֧�ֶ��ȶԹ����˳���������
         str_XY=num2str(perms([F(i) S1{j}]));
         % ��֧�ֶȼ����в��Ҷ�Ӧ��֧�ֶ�
         [~,lib]=ismember(str_XY,str_S);
         % ȥ�������ж����0
         lib=lib(lib~=0);
         % ���������ҵ�֧�ֶ�
         Sup_XY=S{lib,2};
         % �������Ŷ�
         str_X=num2str(F(i));
         Conf_XY=confident(str_X,str_S,S,Sup_XY)
         % ���ɹ���
         % ���Ŷȴ�����С���ŶȲſ��Գ�Ϊ����
         if Conf_XY>minCof
            R=form_rule(R,k,F(i),S1{j},Sup_XY,Conf_XY);
            k=k+1;
         end
         %% ���Y>1������Ҫ����λ��
          if size(S1{j},2)>1
               str_X1=num2str(S1{j});
               Conf_XY=confident(str_X1,str_S,S,Sup_XY)
              % ���ɹ���
              % ���Ŷȴ�����С���ŶȲſ��Գ�Ϊ����
              if Conf_XY>minCof
                %k=k+1;
                R=form_rule(R,k,S1{j},F(i),Sup_XY,Conf_XY);
                k=k+1;
              end
          end
    end
end
% ������Ķ����������
R(k:end,:)=[];






