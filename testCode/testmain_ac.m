clc;
clear;
MaxCount=10;  % 事务集的总类数
TestCount=100;% 实验次数
TestAry=[4,6,8,10,12,14,16,18,20,22];% 各类事务集的大小
ac1=zeros(1,MaxCount);
ac2=zeros(1,MaxCount);

for i=1:MaxCount
    n=TestAry(i);
    p=n;
    [ac1(i),ac2(i)]=accurary(n,p,TestCount);
end

% 画出准确率的图
plot(TestAry,ac1,'-.o');
hold on 
plot(TestAry,ac2,'--+');
title('两种网络的准确率比较')
legend('HNN','MHNN');
xlabel('事务集大小');
ylabel('网络准确率');
axis([0 25 0 1]) 