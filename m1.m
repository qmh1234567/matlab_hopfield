% 仿真忆阻器阻值的变化
% Rm = Mi+dM*V =》Mi是初始值，dM是变化量   V是激励信号
% Mi相当于实体模型中的Ron和Roff之和的二分之一。dM是Ron和Roff的差值的二分之一。使得Rm在Roff和Ron之间连续变化
% 如果要实现忆阻值在正负之间变化，需要将Mi设置为0
% 根据激励信号的不同，忆阻器随时间的变化值不一样。如果是脉冲信号，就是一种二值模型。
w1=1;
t=linspace(0,4);
Rm=cell(20,20);
% 正弦信号
V=sin(2*pi*w1*t);

for i=1:size(Mem1,1)
    for j=1:size(Mem1,2)
        Ron=Mem1(i,j);
        Roff=Mem2(i,j);
        Mi=zeros(1,100);
        dM=(Ron-Roff)/2;
        Rm{i,j} = Mi+dM*V;
    end
end

        


% 设定坐标轴显示范围
% axis([-1,4,-0.5,1.5])