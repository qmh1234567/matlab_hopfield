function [W,I]=newdiff(minSup,T)
global A B C  n p

W = zeros(n*p,n*p);
I = zeros(n,p);
for a=1:n % tow
% 计算动态方程
for i=1:p % column
for b=1:n
   for j=1:p
          % 权值矩阵是一种对称矩阵
          if (a-1)*p+i~=(b-1)*p+j
              X = 0;
              for k=1:n
                  X = X+ T(k,i)*T(k,j);
              end
              Weight = A-C*(minSup-X)*exp(minSup-X);
              % 权值矩阵  np行  np列
              W((a-1)*p+i,(b-1)*p+j)=Weight;
              % 计算权值和输入的累加和
              % sum_x =sum_x + V(b,j)*Weight;
          end
   end
end
    % 阈值
    I(a,i)= B*(1-T(a,i));   
%     dU(a,i) = -U(a,i)/tao+sum_x+I;
end
end





