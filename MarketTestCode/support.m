% ����Ƶ�����֧�ֶ�
function Sup = support(T,F,minSup)
nRules = 1000;
% ����֧�ֶȵ�����
Sup = cell(nRules,2);
% ����ĸ���
D = size(T,1);
% ��������
iter_num=1;
for k=1:length(F)
    % ����F��ȡk������
    R = nchoosek(F,k);
    % ������ʼ��
   for r=1:size(R,1)
       % ����ÿ�����
       SubF = T(:,R(r,:));
       % ���Ƶ�����С����1������һ����ֵĴ���
       count=0; % ������ʼ��
       for t=1:size(SubF,1)
          sub_c=SubF(t,:);
          res = isequal(sub_c,ones(size(sub_c)));
           if res==1
                count=count+1;
           end
       end
       % ����ÿ����Ƶ�����֧�ֶ�
       s = count/D;
       if s>=minSup     
            % ������Ƶ���
            Sup{iter_num,1}=R(r,:);
            % ����֧�ֶ�
            Sup{iter_num,2}=[[];s];
            % ����+1
            iter_num=iter_num+1;
       end
   end
end
% ����������ÿգ�����ռ�ÿռ�
Sup(iter_num:end,:)=[];

