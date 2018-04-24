 Max_Req=[];
for i=1:size(FreqItemsets,2)
%      s=['频繁',num2str(i),'项集'];
%      Res=[Res s];
%     sprintf('频繁%d项集',i)
    matrix=FreqItemsets{1,i}
    for j=1:size(matrix,1)
%         Res=[Res code(matrix(j,:))];
        Max_Req=[Max_Req code(matrix(j,:))]
    end
end