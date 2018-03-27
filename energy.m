function e=energy(minSup,V,T)
global A B C n p
% 初始化
sum_x = 0;
sum_z = 0;
sum_y = 0;
for t=1:n % column
% 计算动态方程
for i=1:p % tow
   for j=1:p
       if j~=i
           sum_x =sum_x+V(t,i)*V(t,i);
           X = 0;
           for k=1:n
              X = X+T(k,i)*T(k,i);
           end
           sum_z =sum_z+V(t,i)*V(t,j)*(minSup-X)*exp(minSup-X);
       end
   end
    sum_y = sum_y + B*V(t,i)*(1-T(t,i));
end
end
e = -A/2*sum_x+B*sum_y+C/2*sum_z;

          