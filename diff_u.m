function dU=diff_u(U,minSup,V,T)
global A B C tao n p
dU = zeros(size(U));  % ��ʼ��Ϊȫ0����
for a=1:n % tow
% ���㶯̬����
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
    dU(a,i) = -U(a,i)/tao+sum_x+I; %�޸�du��ÿһ��
end
end

