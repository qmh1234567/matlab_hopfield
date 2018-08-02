%% ʹ��Hopfield�����ھ��������
function [Freq,Rcount,Ecount]=Copy_of_HNN_main(T,code,W,I)
% �û��Զ�����С֧�ֶȡ���С���Ŷ�
minSup = 0.5;
minCof = 0.5;
% ���ݾ���ָ������ر���
tao = 1;
lambda =3;
%% ���ɽ��׼�
%% ������ʼ��
% inputfile = 'test1.txt';
% outputfile= 'as.txt'; % ���ת�����01����
% % ���ñ��뺯���������׼�ת��Ϊ01����
% [T,code]= trans2matrix(inputfile,outputfile,' ');
% % ��Ŀ��
n = size(T,1);
% ��С֧�ֶȼ��� ȡ��ӽ�������
minSupCount=round(minSup*n);
% % ������
p = size(T,2);
% U��ʼ��ΪT
U = T;
disp('��һ�ε�U')
disp(U)
V =(1+tanh(lambda*U))/2;
% ������������ֵ�ľ���
E = zeros(1,1000);

%% �������Ƶ���
N=n*p;
% �����Ȩֵ����ֵ
% [W,I]=newdiff(minSupCount,T,n,p);
%% ��Ȩ�ؾ�����д���
% ����Ԫ���������Ȩ�ؾ�������ֵ
MaxValue=1;
for i=1:N
    newMaxValue=max(abs(W{i}));
    if MaxValue<newMaxValue
        MaxValue=newMaxValue;
    end
end
% ȡȨ�����ֵ������
x=real(fix(log10(MaxValue)));
%% ������������Ͳ���
% ��������
if x>4
    step=10^(-(x+3));
    Count=150;
else
    step=10^(-(x+2));
    Count=500;
end
%% �ҳ����Ƶ���
dU = zeros(size(U)); %��ʼ��Ϊȫ0����
% ���е������ҳ�Ƶ���
k=1;%��������
 while k<Count
     m=1;% Ȩ�ؾ����������ʼ��
     % ����du
    for a=1:n
        for i=1:p
            sum_x = W{m}*reshape(V',[N,1]);%��ԭ��n��p�е���������ع�ΪN��1��
            if x>4
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);
            else
             dU(a,i)=-U(a,i)/tao+sum_x+I(a,i);  
            end
            m=m+1;
        end
    end
     % ����������Ԫ
     U= U+dU*step;
     V = (1+tanh(lambda*U))/2;
     % ����������ȫ0��˵���Ҳ���Ƶ��2��ģ�����ǰ�˳�
     if any(any(V))==0
         break;
     end
     % ������������
    e = energy(minSupCount,V,T,n,p);
    E(k)=e;
    k=k+1;
 end

%% ������  �����������ߡ����Ƶ�������������
% ���������������������
E(k:end)=[];
% % ������������ͼ
% plot(E)
% xlabel('��������')
% ylabel('��������')
% title('���������仯����')
Ecount=0;
% �ҵ������ȶ�����С�Ĵ���
for i=size(E,2):-1:1
    if(abs(abs(E(i))-abs(E(end)))>500)
        Ecount=i;
        break;
    end
end

% ������Ƶ���
Frequent=int8(V);
index=zeros(1,size(Frequent,2));
k=1;
% ֻ��Ҫȫ1���У�����������1����
for i=1:size(Frequent,2)
     if(Frequent(:,i)==ones(size(Frequent,1),1))
         index(k)=i;
         k=k+1;
     end
end
index(k:end)=[];
F = unique(index');
disp('���Ƶ���Ϊ:')
Freq = code(F);

% �������Ƶ������ɹ�������
% ����ÿ�������֧�ֶ�  ֧�ֶ�Ϊ0.3
S = support(T,F,minSup);
% ����������� 1�ǰ���֧�ֶ�����  2�ǰ������Ŷ�����,0��main  1��copyofmain,���Ŷ�Ϊ0.3
R=rule(S,1,1,minCof,code);
Rcount=size(R,1);

    

                