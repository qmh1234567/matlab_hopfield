function Sk = deduct(S,Sub_S)
% ��S�������ҵ���Sub_S���ཻ�ļ���
for i=1:size(Sub_S,2)
    % ��ȡ��������ÿһ������
      k=Sub_S(1,i);
    % ��S��ÿһ���ж���Щ������S���Ƿ���ڣ����򷵻�1�����򷵻�0
      s1=cellfun(@(x) any(x(:)==k),S(:,1),'UniformOutput',false);
      % ��cellת��Ϊlogical�;���
      mat_s1=cell2mat(s1);
     % �Ӿ������ҵ�����Ϊ1������
      [index,~]=find(mat_s1==1);
      % ��������ɾ������
      S(index,:)=[];
end
Sk=S;

