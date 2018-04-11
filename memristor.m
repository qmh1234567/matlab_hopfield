% �������ľ�ȷ����ģ��MATLAB����
function resistance=memristor(time,voltage,r_i,dt,r_on,r_off,V_th_pos,V_th_neg,T_pos,T_neg)
% time ��������  voltage ʩ�����������ϵĵ�ѹ
% r_i ��һ��ʱ����������ֵ dt ʱ�����С����
% V_th_pos �������������ѹ��ֵ  V_th_neg �������ĸ����ѹ��ֵ
% T_pos ����ֵ��Roff���ٵ�Ron����ʱ��   T_neg ����ֵ��Ron���ӵ�Roff����ʱ��
%% memristor resistance
% Ϊ��������ֵ�����ڴ�
resistance=zeros(1,200);
resistance(1)=r_i;
i1=1;
for i=2:length(time)
    % �����ѹ�����������������ѹ��ֵ
    if(voltage(i1)>V_th_pos)
        resistance(i)=resistance(i-1)-((r_off-r_on)*dt*voltage(i1))/(T_pos*V_th_pos);
        % resistance(i)-resisance(i-1)
        if(resistance(i)>r_off)
            resistance(i)=r_off;
        end
        if(resistance(i)<r_on)
            resistance(i)=r_on;
        end
     % �����ѹС���������ĸ����ѹ��ֵ
    elseif(voltage(i1)<((-1)*V_th_neg))
        resistance(i)=resistance(i-1)-((r_off-r_on)*dt*voltage(i1))/(T_neg*V_th_neg);
        if(resistance(i)>r_off)
            resistance(i)=r_off;
        end
        if(resistance(i)<r_on)
            resistance(i)=r_on;
        end
     % �����������������
    else
        resistance(i)=resistance(i-1);
    end
    i1=i;
end
        