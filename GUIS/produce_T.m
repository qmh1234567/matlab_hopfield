function [T code]=produce_T(n,p)
% ����������׾���
T= randi([0,1],n,p);
% �����  �����30����Ʒ
MyCodes={'����','�ǹ�','����','�·�','ѥ��','����','ϴ����','��ԡ¶','ϴ��ˮ','����','����','���','����','��ָ','����','��ӡ��','����','�ֵ�','�����','Χ��','���','����','��ˮ��','̨��','ָ����','ë��','��ˮƿ','ˮ��','���','����ֽ'};
Total_num=length(MyCodes);
% �������������� randperm(N,K) ����1-N�Ĳ��ظ�������K��
code=MyCodes(randperm(Total_num,p));

% ���ɹ����嵥txt
fid=fopen('mygoods.txt','w');
for i=1:size(T,1)
    % ���Ԫ��Ϊ1�����±�
    [~,ib]=find(T(i,:)==1);
    % ���б��� ��cell����ת��Ϊ�ַ�����
    code1=code(ib);
    % ��Ϊ��ͬ��cell֮�䲻���пո���Ҫ�ֶ����
    code2=cellfun(@(u)[u,' '],code1(1:end),'UniformOutput',false);
    str_arry=cell2mat(code2);
    % д���ļ�
    fprintf(fid,'%s\n',str_arry);
end
fclose(fid);
disp(['���ɹ����嵥��''mygoods.txt' '���!']);

% ���ɽ��׼�T��txt
fid1=fopen('Tvalue.txt','w');
for i=1:size(T,1)
    fprintf(fid1,'%s\n',num2str(T(i,:)));
end
fclose(fid);
disp(['���ɽ��׼�T��' 'Tvalue.txt' '���!']);