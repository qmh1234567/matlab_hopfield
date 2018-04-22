% 忆阻器的精确线性模型MATLAB仿真
function resistance=memristor(time,voltage,r_i,dt,r_on,r_off,V_th_pos,V_th_neg,T_pos,T_neg)
% time 迭代次数  voltage 施加在忆阻器上的电压
% r_i 第一次时忆阻器的阻值 dt 时间的最小步长
% V_th_pos 忆阻器的正向电压阈值  V_th_neg 忆阻器的负向电压阈值
% T_pos 忆阻值从Roff减少到Ron所需时间   T_neg 忆阻值从Ron增加到Roff所需时间
%% memristor resistance
% 为忆阻器阻值分配内存
resistance=zeros(1,200);
resistance(1)=r_i;
i1=1;
for i=2:length(time)
    % 如果电压大于忆阻器的正向电压阈值
    if(voltage(i1)>V_th_pos)
        resistance(i)=resistance(i-1)-((r_off-r_on)*dt*voltage(i1))/(T_pos*V_th_pos);
        % resistance(i)-resisance(i-1)
        if(resistance(i)>r_off)
            resistance(i)=r_off;
        end
        if(resistance(i)<r_on)
            resistance(i)=r_on;
        end
     % 如果电压小于忆阻器的负向电压阈值
    elseif(voltage(i1)<((-1)*V_th_neg))
        resistance(i)=resistance(i-1)-((r_off-r_on)*dt*voltage(i1))/(T_neg*V_th_neg);
        if(resistance(i)>r_off)
            resistance(i)=r_off;
        end
        if(resistance(i)<r_on)
            resistance(i)=r_on;
        end
     % 上面两种情况都不是
    else
        resistance(i)=resistance(i-1);
    end
    i1=i;
end
        