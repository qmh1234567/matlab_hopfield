function Sk = deduct(S,k)
% �����ҵ�����ĳ�����ݵ�Ԫ��
% ��ÿһ���ж��Ƿ���kֵ�����򷵻�1�����򷵻�0
s1=cellfun(@(x) any(x(:)==k),S(:,1),'UniformOutput',false);
Sk=S;
% �ٴ�Ԫ�����ҵ���ֵΪ1������
index=[];
for i=1:size(s1)
   if s1{i}==1
        index=[index;i];
    end
end
% ��������ɾ��Ԫ��
Sk(index,:)=[];