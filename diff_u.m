function [dU,W]=diff_u(U,minSup,V,T)
global A B C tao n p
dU = zeros(size(U));  % ��ʼ��Ϊȫ0����
W = zeros(n*p,n*p);
for a=1:n % tow
% ���㶯̬����
for i=1:p % column
   sum_x = 0;
for b=1:n
   for j=1:p
          % Ȩֵ������һ�ֶԳƾ���
          if (a-1)*p+i~=(b-1)*p+j
              X = 0;
              for k=1:n
                  X = X+ T(k,i)*T(k,j);
              end
              Weight = A-C*(minSup-X)*exp(minSup-X);
              % Ȩֵ����  np��  np��
              W((a-1)*p+i,(b-1)*p+j)=Weight;
              % ����Ȩֵ��������ۼӺ�
              sum_x =sum_x + V(b,j)*Weight;
          end
   end
end
    I= B*(1-T(a,i));
    dU(a,i) = -U(a,i)/tao+sum_x+I; %�޸�du��ÿһ��             

end
end





