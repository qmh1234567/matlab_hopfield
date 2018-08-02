% 输出候选集或者频繁项集
function output_set(code,matrix)

for i=1:size(matrix,1)
        disp(code(matrix(i,:)))
    end
end