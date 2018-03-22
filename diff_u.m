function dU=diff_u(U,minSup,V,T)
global A B C tao
[p,n]=size(T);
for t=1:n % column
% 计算动态方程
for i=1:p % tow
   for j=1:p
       if j~=i
          for k=1:n
              X = minSup-T(i,k)*T(j,k);
          end
          Weight = A-C*X*exp(X);
          sum_x = V(j,t)*Weight;
       end
    end
    I= B*(1-T(i,t));
    dU = -U/tao+sum_x-I;
end
end

