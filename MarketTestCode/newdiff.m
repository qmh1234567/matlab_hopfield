function [W,I]=newdiff(minSup,T,n,p)
% A = 350;
% B = 100;
% C = 110;
A = 550;
B = 100;
C = 100;
N=n*p;
W=cell(N,1); %存储权重的单元数组
m=1;
I = zeros(n,p); % 存储阈值的矩阵
for a=1:n
for i=1:p
        m1=1;
        W{m,1}=zeros(1,N);
        for b=1:n
            for j=1:p
                % 权值矩阵是对称矩阵
                if (a-1)*p+i~=(b-1)*p+j
                    X = 0;
                    for k=1:n
                         X = X+ T(k,i)*T(k,j);
                    end  
                    Weight = A-C*(minSup-X)*exp(minSup-X);
                    W{m,1}(1,m1)=Weight; % 每个神经元受到的权重值
                end
                m1=m1+1;
            end
        end
       m=m+1;
       % 阈值
       I(a,i)= B*(1-T(a,i));  
end
end



% 
% 
% 
% 
% % W = zeros(n*p,n*p);
% 
% I = zeros(n,p);
% for a=1:n % tow
% % 计算动态方程
% for i=1:p % column
% for b=1:n
%    for j=1:p
%           
%           % 权值矩阵是一种对称矩阵
%           if (a-1)*p+i~=(b-1)*p+j
%               X = 0;
%               for k=1:n
%                   X = X+ T(k,i)*T(k,j);
%               end
%               Weight = A-C*(minSup-X)*exp(minSup-X);
%               % 权值矩阵  np行  np列
%               W((a-1)*p+i,(b-1)*p+j)=Weight;
%               % 计算权值和输入的累加和
%               % sum_x =sum_x + V(b,j)*Weight;
%           end
%    end
% end
%     % 阈值
%     I(a,i)= B*(1-T(a,i));   
% %     dU(a,i) = -U(a,i)/tao+sum_x+I;
% end
% end





