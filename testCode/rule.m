%% �����������
function R=rule(S,sortFlag,mainFlag)
global nRules minCof
if mainFlag==0
    rulesfile='oldrules.txt';
elseif mainFlag==1
    rulesfile = 'rules.txt'; % �����������
else
    rulesfile='CMrules.txt';
end
% ������������
R=cell(nRules,4);
% ��������
k=1;
% % ��֧�ֶ�����ת��Ϊ�ַ������͵�
% str_S=cellfun(@(x) num2str(x),S(:,1),'UniformOutput',false);
% ��ʼѰ�ҹ�������
for i=1:size(S,1)
    % ȡ��ÿһ�У��ҵ�����в��ཻ�ļ���
    Sub_S =S{i,:};
    S1 = deduct(S,Sub_S);
    % ������ɹ�������
    for j=1:size(S1,1)
        % ����֧�ֶ� ������˳��
        % ��XY��֧�ֶ��ȶԹ����˳���������
        XY=perms([Sub_S S1{j}]);
        % ��֧�ֶȼ����в��Ҷ�Ӧ��֧�ֶ�
         for t=1:size(XY,1)
            lib=cellfun(@(x)isequal(x,XY(t,:)),S(:,1));
            if any(lib)~=0
                break;
            end
         end
        % �ҵ�1����Ӧ������
        lib=find(lib==1);
        if isempty(lib)
            continue;
        end
        % ���������ҵ�֧�ֶ�
        Sup_XY=S{lib,2};
        % �������Ŷ�
        str_X=Sub_S;
        Conf_XY=confident(str_X,S,Sup_XY);
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
% ������д���ļ�
ShowRule(rulesfile,R);



function Conf_XY=confident(X,S,Sup_XY)
 % ��֧�ֶȼ����в��Ҷ�Ӧ��֧�ֶ�
lib=cellfun(@(x)isequal(x,X),S(:,1));
% �ҵ�1����Ӧ������
libx=find(lib==1);
% ���������ҵ�X��֧�ֶ�
Sup_X=S{libx,2};
% �������Ŷ�
Conf_XY=Sup_XY/Sup_X;


function R=form_rule(R,k,X,Y,Sup_XY,Conf_XY)
% �����X
R{k,1}=X;
% �����Y
R{k,2}=Y;
% ֧�ֶ��������ĵ�����
R{k,3}=Sup_XY;
% ���Ŷ��������ĵ�4��
R{k,4}=Conf_XY;


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

function ShowRule(rulesfile,R)
global code
% ���������������txt��
fid=fopen(rulesfile,'w');
fprintf(fid,'%s (%s,%s) \n','Rule','Support','Confidence');
for i=1:size(R,1)
    s1 ='';
    s2 ='';
    for j = 1:size(R{i,1},2)
        if j == size(R{i,1},2)
            s1= [s1 code{R{i,1}(j)}];
        else
            s1 = [s1 code{R{i,1}(j)} ' '];
        end
    end
    %s1=cell2mat(code(R{i,1}));
    for j = 1:size(R{i,2},2)
        if j == size(R{i,2},2)
            s2 = [s2 code{R{i,2}(j)}];
        else
            s2 = [s2 code{R{i,2}(j)} ' '];
        end
    end
    %s2=cell2mat(code(R{i,2}));
    s3=num2str(R{i,3}*100);
    s4=num2str(R{i,4}*100);
    fprintf(fid,'%s -> %s (%s%%,%s%%)\n',s1,s2,s3,s4);
end
fclose(fid);
disp(['�洢�����ļ�' rulesfile '���' '������Ϊ' num2str(size(R,1)) '��'])








