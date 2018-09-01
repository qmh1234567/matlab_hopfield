function e=energy(minSup,V,T,n,p)
A = 350;
B = 100;
C = 110;
% A = 550;
% B = 100;
% C = 100;
% 初始化
sum_x = 0;
sum_z = 0;
sum_y = 0;
% 计算能量函数
for a=1:n % row
for i=1:p % column
   for b=1:n
       for j=1:p
            if j~=i
                sum_x =sum_x+V(a,i)*V(b,j);
                X = 0;
                for k=1:n
                     X = X+T(k,i)*T(k,i);
                end
                sum_z =sum_z+V(a,i)*V(b,j)*(minSup-X)*exp(minSup-X);
            end
       end
   end
    sum_y = sum_y + V(a,i)*(1-T(a,i));
end
end
e = -A/2*sum_x-B*sum_y+C/2*sum_z;

          