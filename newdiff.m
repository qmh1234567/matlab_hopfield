function [W,I]=newdiff(minSup,T)
global A B C  n p

W = zeros(n*p,n*p);
I = zeros(n,p);
for a=1:n % tow
% ���㶯̬����
for i=1:p % column
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
              % sum_x =sum_x + V(b,j)*Weight;
          end
   end
end
    % ��ֵ
    I(a,i)= B*(1-T(a,i));   
%     dU(a,i) = -U(a,i)/tao+sum_x+I;
end
end





