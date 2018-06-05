clc;
clear;
MaxCount=10;  % ���񼯵�������
TestCount=100;% ʵ�����
TestAry=[4,6,8,10,12,14,16,18,20,22];% �������񼯵Ĵ�С
ac1=zeros(1,MaxCount);
ac2=zeros(1,MaxCount);

for i=1:MaxCount
    n=TestAry(i);
    p=n;
    [ac1(i),ac2(i)]=accurary(n,p,TestCount);
end

% ����׼ȷ�ʵ�ͼ
plot(TestAry,ac1,'-.o');
hold on 
plot(TestAry,ac2,'--+');
title('���������׼ȷ�ʱȽ�')
legend('HNN','MHNN');
xlabel('���񼯴�С');
ylabel('����׼ȷ��');
axis([0 25 0 1]) 