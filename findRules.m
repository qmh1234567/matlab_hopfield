function [Rules,FreqItemsets] = findRules(transactions, minSup, minConf, nRules, sortFlag, code, rulesfile)
% INPUT:
%          transactions:  M x N matrix of binary transactions, where each row
%                                  represents one transaction and each column represents
%                                  one attribute/item
%          minSup:          scalar value that represents the minimum
%                                  threshold for support for each rule
%          minConf:        scalar value that represents the minimum
%                                  threshold for confidence of each rule
%          nRules:           scalar value indicating the number of rules
%                                  the user wants to find
%          sortFlag:         binary value indicating if the rules should be
%                                  sorted by support level or confidence level
%                                  1: sort by rule support level
%                                  2: sort by rule confidence level
%          code (labels): 编码规则            optional parameter that provides labels for
%                                  each attribute (columns of transactions),
%                                  by default attributes are represented
%                                  with increasing numerical values 1:N
%           
%          fname:            optional file name where rules are saved
%
% OUTPUT:
%          Rules:             2 x 1 cell array, where the first cell (Rules{1}{:})
%                                 contains the itemsets in the left side of the rule and second
%                                 cell (Rules{2}{:}) contains the itemsets
%                                 in the right side of the rule (e.g., if
%                                 the first rule is {1, 2} -> 3,
%                                 Rules{1}{1} = [1,2], Rules{2}{1} = [3])
%         FreqItemsets: A cell array of frequent itemsets of size 1, 2,
%                                 etc., with itemset support >= minSup,
%                                 where FreqItemSets{1} represents itemsets
%                                 of size 1, FreqItemSets{2} itemsets of
%                                 size 2, etc.
%         fname.txt:      The code creates a text file and stores all the
%                                 rules in the form left_side -> right_side.
%

% Number of transactions in the dataset
% 交易笔数
M = size(transactions,1);
% Number of attributes in the dataset
% 物品种类
N = size(transactions,2);

if nargin < 7
    rulesfile = 'default';
end

if nargin < 6
    code = cellfun(@(x){num2str(x)}, num2cell(1:N));
end

if nargin < 5
    sortFlag = 1;
end

if nargin < 4
    nRules = 100;
end

if nargin < 3
    minConf = 0.5;
end

if nargin < 2
    minSup = 0.5;
end

if nargin == 0
    error('No input arguments were supplied.  At least one is expected.');
end

% Preallocate memory for Rules and FreqItemsets
maxSize = 10;
Rules = cell(2,1);
Rules{1} = cell(nRules,1);
Rules{2} = cell(nRules,1);
FreqItemsets = cell(maxSize);
RuleConf = zeros(nRules,1);
RuleSup = zeros(nRules,1);
ct = 1;

% Find frequent item sets of size one (list of all items with minSup)
% 找到size为1的频繁项集
T = [];
for i = 1:N
    S = sum(transactions(:,i))/M;
    if S >= minSup
        % 输出size为1的频繁项集
        disp([code(i) S]);
        T = [T; i];
    end
end
FreqItemsets{1} = T;


%Find frequent item sets of size >=2 and from those identify rules with minConf
% 找到size>=2的频繁项集
for steps = 2:N
    % If there aren't at least two items  with minSup terminate
    % 如果交易数据量少于2，就终止
    sprintf('-----------step=%d-----------',steps)
    sprintf('频繁%d项集为',steps-1) 
    output_set(code,T)
    U = unique(T);
    % 如果频繁项集只有1行时退出
    if isempty(U) || size(U,1) == 1
        Rules{1}(ct:end) = [];
        Rules{2}(ct:end) = [];
        % 修改
        FreqItemsets(steps:end) = [];
        break
    end
    % Generate all combinations of items that are in frequent itemset
    % 在频繁项集中生成所有的子集-->候选项集
    Combinations = nchoosek(U',steps);  % 返回U的所有组合  可能是用来产生候选项集
    %sprintf('可能的候选%d项集为',steps)
   % output_set(code,Combinations)
   % 交易数据放在Told中
   % T为频繁项集
    TOld = T;
    T = [];
    for j = 1:size(Combinations,1)
        if ct > nRules
            break;
        else
            % 如果有子集不是频繁项集的，就不考虑它的超集
            % Apriori rule: if any subset of items are not in frequent itemset do not
            % consider the superset (e.g., if {A, B} does not have minSup do not consider {A,B,*})
            % nchoosek(Combinations(j,:),steps-1) 生成候选集的子集
            if sum(ismember(nchoosek(Combinations(j,:),steps-1),TOld,'rows')) - steps+1>0 %如果候选集的子集也是频繁项集的话
               sprintf('满足要求的候选集为:')
               output_set(code,Combinations(j,:))
               disp(Combinations(j,:))
                sprintf('候选集子集')
                disp(nchoosek(Combinations(j,:),steps-1))
                % Calculate the support for the new itemset
                % 计算该集合的支持度
                % sum(transactions(:,Combinations(j,:)),2) 返回每一行的总和
                % disp(transactions(:,Combinations(j,:)))
                S = mean((sum(transactions(:,Combinations(j,:)),2)-steps)>=0);
                sprintf('该候选集的支持度为%d',S)
                if S >= minSup
                    % 添加到频繁项集中
                    T = [T; Combinations(j,:)];
                    % Generate potential rules and check for minConf
                    for depth = 1:steps-1
                        R = nchoosek(Combinations(j,:),depth);
                        for r = 1:size(R,1)
                            if ct > nRules
                                break;
                            else
                                % Calculate the confidence of the rule
                                % 计算规则的置信度
                                Ctemp = S/mean((sum(transactions(:,R(r,:)),2)-depth)==0);
                                if Ctemp > minConf
                                    % b保存拥有最小支持度和最小置信度的规则
                                    % Store the rules that have minSup and minConf
                                    Rules{1}{ct} = R(r,:);
                                    % setdiff(A,B）返回A中存在但B中不存在的数据
                                    Rules{2}{ct} = setdiff(Combinations(j,:),R(r,:));
                                    RuleConf(ct) = Ctemp;
                                    RuleSup(ct) = S;
                                    ct = ct+1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
     % 保存频繁项集
    % Store the freqent itemsets
    FreqItemsets{steps} = T;
end


% 打印出所有的频繁项集
sprintf('打印出所有的频繁项集')
for i=1:size(FreqItemsets,2)
    sprintf('频繁%d项集',i)
    output_set(code,FreqItemsets{1,i});
end


% 扔掉预分配时多余的行
% Get rid of unnecessary rows due to preallocation (helps with speed)
FreqItemsets(steps:end) = [];
RuleConf = RuleConf(1:ct-1);
RuleSup = RuleSup(1:ct-1);



% Sort the rules in descending order based on the confidence or support level
switch sortFlag
    case 1 % Sort by Support level
        [V ind] = sort(RuleSup,'descend');
    case 2 % Sort by Confidence level
        [V ind] = sort(RuleConf,'descend');
end

RuleConf = RuleConf(ind);
RuleSup = RuleSup(ind);

for i = 1:2
    temp = Rules{i,1};
    temp = temp(ind);
    Rules{i,1} = temp;
end

disp(['关联规则算法完成,规则数为：' num2str(size(RuleSup,1))]);

% Save the rule in a text file and print them on display
fid = fopen(rulesfile, 'w');
fprintf(fid, '%s   (%s, %s) \n', 'Rule', 'Support', 'Confidence');

for i = 1:size(Rules{1},1)
    s1 = '';
    s2 = '';
    for j = 1:size(Rules{1}{i},2)
        if j == size(Rules{1}{i},2)
            s1 = [s1 code{Rules{1}{i}(j)}];
        else
            s1 = [s1 code{Rules{1}{i}(j)} ','];
        end
    end
    for k = 1:size(Rules{2}{i},2)
        if k == size(Rules{2}{i},2)
            s2 = [s2 code{Rules{2}{i}(k)}];
        else
            s2 = [s2 code{Rules{2}{i}(k)} ','];
        end
    end
    s3 = num2str(RuleSup(i)*100);
    s4 = num2str(RuleConf(i)*100);
    fprintf(fid, '%s -> %s  (%s%%, %s%%)\n', s1, s2, s3, s4);
end
fclose(fid);
disp(['存储规则到文件‘' rulesfile '’完成'])
end