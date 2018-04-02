function dU=diff_u(U,minSup,V,T)
global A B C tao n p
dU = zeros(size(U));  % 初始化为全0矩阵
for a=1:n % tow
% 计算动态方程
for i=1:p % column
   sum_x = 0;
for b=1:n
   for j=1:p
          if j~=i
              X = 0;
              for k=1:n
                  X = X+ T(k,i)*T(k,j);
              end
              Weight = A-C*(minSup-X)*exp(minSup-X);
              sum_x =sum_x + V(b,j)*Weight;
          end
   end
end
    I= B*(1-T(a,i));
    dU(a,i) = -U(a,i)/tao+sum_x+I; %修改du的每一项
end
end

