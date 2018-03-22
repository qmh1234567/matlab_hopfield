function e=energy(minSup,V,T)
global A B C 
[p,n]=size(T);
for t=1:n % column
% 计算动态方程
for i=1:p % tow
   for j=1:p
       if j~=i
           sum_x = -A/2*V(i,t)*V(j,t);
           sum_y = B*V(i,t)*(1-T(i,t));
           for k=1:n
              X = minSup-T(i,k)*T(j,k);
           end
           sum_z = C/2*V(i,t)*V(j,t)*X*exp(X);
       end
   end
end
end
e = sum_x+sum_y+sum_z;
          