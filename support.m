% ����Ƶ�����֧�ֶ�
function Sup = support(T,F)
global nRules
% ����֧�ֶȵ�����
Sup = cell(nRules,2);
% ����ĸ���
D = size(T,1);
% ��������
t=1;
for k=1:length(F)
    % ����F��ȡk������
    R = nchoosek(F,k);
   for r=1:size(R,1)
       % ����ÿ�����
       SubF = T(:,R(r,:));
       % ���Ƶ�����С����1������һ����ֵĴ���
       if size(SubF)>1
           count=length(SubF)-length(unique(SubF));
       else
           count=sum(SubF); % Ƶ��1�
       end
       % ����ÿ����Ƶ�����֧�ֶ�
       s = count/D;
       % ������Ƶ���
       Sup{t,1}=R(r,:);
       % ����֧�ֶ�
       Sup{t,2}=[[];s];
       % ����+1
       t=t+1;
   end
end
% ����������ÿգ�����ռ�ÿռ�
Sup(t:end,:)=[];


