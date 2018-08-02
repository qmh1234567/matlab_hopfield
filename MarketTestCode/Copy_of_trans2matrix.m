function[output,code]=Copy_of_trans2matrix(inputfile,outputfile,splitter)
%% ����������ת��Ϊ0 1����ÿ�д���һ������
% �������
% inputfile :�����ļ����ո�ָ�ÿ����Ŀ
% outputfile: ����ļ���ת�����0��1�����ļ�
% splitter:�����ļ��ļ������Ĭ��Ϊ�ո�
% �������
% output:ת�����0��1����   code �������

if nargin<3 % �������������Ŀ
    splitter=' ';
end

%% �����ļ� ��ȡ�������
fid = fopen(inputfile);
tline = fgetl(fid);  % ��ȡ�ļ��е�ÿһ�У���ȥ�����з�
lines = 0;
code=cell(1,100);
k=1;
while ischar(tline)
    if lines<20
        lines=lines+1; % ��¼����
        tline= deblank(tline); % ȥ����β����Ŀո�
        tline = regexp(tline,splitter,'split'); % ƥ��������ʽ���ڷָ���������ı�
        code{1,k}=tline;
        k=k+1;
    %   code =[code tline]; %�ϲ�
        code = unique(code); %ȥ���ظ���¼
        tline = fgetl(fid);
    end
end


code{1,k+1:end}=[];

disp('�������Ϊ��')
disp(num2str(1:size(code,2)))
disp(code);
fclose(fid); % �ر��ĵ�

% ��ȡ�ļ������ݱ�������ԭʼ���ݽ���ת��
itemsnum = size(code,2); % ȡ��Ԫ�����е���

output = zeros(lines,itemsnum);

fid = fopen(inputfile);
tline = fgetl(fid);
lines = 0;
while ischar(tline)
    if lines<20
        lines=lines+1; %��¼����
        tline=deblank(tline);
        tline=regexp(tline,splitter,'split');
        [~,icode,~] = intersect(code,tline);% Ѱ���±�
        output(lines,icode)=1;
        tline=fgetl(fid);
    end
end
fclose(fid);

%% ��ת����ľ���д���ļ�
fid = fopen(outputfile,'w');
for i=1:lines
    fprintf(fid,'%s\n',num2str(output(i,:)));
end
fclose(fid);
end


