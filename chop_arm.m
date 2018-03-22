function [Rules,FreqItemsets] = findRules(T,minSup,minCof,nRules,sortFlag,code,rulefile)
% ����˵����
% ����  T:���׼��� ÿ�д���һ�ʽ��� ÿ�д���һ����Ʒ����
%       minSup��С֧�ֶ�   minCof��С���Ŷ� 
%       nRules ��������   sortFlag �Ƿ���֧�ֶ�����
%       code  �������  rulefile  �������
% ���  Rules  2 x 1��Ԫ������  Rules{1}{:}��Ź������� Rules{2}{:}��Ź�����ұ�
%       FreqItemsets  ������ִ�С��Ƶ���

% ��Ŀ��
p = size(T,1);
% ������
n = size(T,2);
% ���ݾ���ָ������ر���
A = 550;
B = 100;
C = 200;
t = 1;
lambda =3;

step=0.0001;
% ����ĳ�ʼ�� 
U = randint(p,n);  % ����һ��p��n�е�0 1�������
V = (1+tanh(lamda*U))/2;   % ������Ԫ������󵥸���Ԫ���
iter_num =1000;  % �����������Ϊ1000
E = zeros(1,iter_num);
% Ѱ�ŵ���
for k = 1:iter_num
    % ���㶯̬����
    dU = diff_u(minSup,V,T);
    % ����������Ԫ״̬
    U = U +dU*step;
    % ���������Ԫ״̬
    V = (1+tanh(lamda*U))/2;
    % ������������
    e = energy(V,T);
    E(k)=e;
end
    


        

