 Max_Req=[];
for i=1:size(FreqItemsets,2)
%      s=['Ƶ��',num2str(i),'�'];
%      Res=[Res s];
%     sprintf('Ƶ��%d�',i)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
%         Res=[Res code(matrix(j,:))];
        Max_Req=[Max_Req code(matrix(j,:))]
    end
end