function [W,I]=newdiff(minSup,T,n,p)
% A = 350;
% B = 100;
% C = 110;
A = 550;
B = 100;
C = 100;
N=n*p;
W=cell(N,1); %�洢Ȩ�صĵ�Ԫ����
m=1;
I = zeros(n,p); % �洢��ֵ�ľ���
for a=1:n
for i=1:p
        m1=1;
        W{m,1}=zeros(1,N);
        for b=1:n
            for j=1:p
                % Ȩֵ�����ǶԳƾ���
                if (a-1)*p+i~=(b-1)*p+j
                    X = 0;
                    for k=1:n
                         X = X+ T(k,i)*T(k,j);
                    end  
                    Weight = A-C*(minSup-X)*exp(minSup-X);
                    W{m,1}(1,m1)=Weight; % ÿ����Ԫ�ܵ���Ȩ��ֵ
                end
                m1=m1+1;
            end
        end
       m=m+1;
       % ��ֵ
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
% % ���㶯̬����
% for i=1:p % column
% for b=1:n
%    for j=1:p
%           
%           % Ȩֵ������һ�ֶԳƾ���
%           if (a-1)*p+i~=(b-1)*p+j
%               X = 0;
%               for k=1:n
%                   X = X+ T(k,i)*T(k,j);
%               end
%               Weight = A-C*(minSup-X)*exp(minSup-X);
%               % Ȩֵ����  np��  np��
%               W((a-1)*p+i,(b-1)*p+j)=Weight;
%               % ����Ȩֵ��������ۼӺ�
%               % sum_x =sum_x + V(b,j)*Weight;
%           end
%    end
% end
%     % ��ֵ
%     I(a,i)= B*(1-T(a,i));   
% %     dU(a,i) = -U(a,i)/tao+sum_x+I;
% end
% end





