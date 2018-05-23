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
%          code (labels): �������            optional parameter that provides labels for
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
% ���ױ���
M = size(transactions,1);
% Number of attributes in the dataset
% ��Ʒ����
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
% �ҵ�sizeΪ1��Ƶ���
T = [];
for i = 1:N
    S = sum(transactions(:,i))/M;
    if S >= minSup
        % ���sizeΪ1��Ƶ���
        disp([code(i) S]);
        T = [T; i];
    end
end
FreqItemsets{1} = T;


%Find frequent item sets of size >=2 and from those identify rules with minConf
% �ҵ�size>=2��Ƶ���
for steps = 2:N
    % If there aren't at least two items  with minSup terminate
    % �����������������2������ֹ
    sprintf('-----------step=%d-----------',steps)
    sprintf('Ƶ��%d�Ϊ',steps-1) 
    output_set(code,T)
    U = unique(T);
    % ���Ƶ���ֻ��1��ʱ�˳�
    if isempty(U) || size(U,1) == 1
        Rules{1}(ct:end) = [];
        Rules{2}(ct:end) = [];
        % �޸�
        FreqItemsets(steps:end) = [];
        break
    end
    % Generate all combinations of items that are in frequent itemset
    % ��Ƶ������������е��Ӽ�-->��ѡ�
    Combinations = nchoosek(U',steps);  % ����U���������  ����������������ѡ�
    %sprintf('���ܵĺ�ѡ%d�Ϊ',steps)
   % output_set(code,Combinations)
   % �������ݷ���Told��
   % TΪƵ���
    TOld = T;
    T = [];
    for j = 1:size(Combinations,1)
        if ct > nRules
            break;
        else
            % ������Ӽ�����Ƶ����ģ��Ͳ��������ĳ���
            % Apriori rule: if any subset of items are not in frequent itemset do not
            % consider the superset (e.g., if {A, B} does not have minSup do not consider {A,B,*})
            % nchoosek(Combinations(j,:),steps-1) ���ɺ�ѡ�����Ӽ�
            if sum(ismember(nchoosek(Combinations(j,:),steps-1),TOld,'rows')) - steps+1>0 %�����ѡ�����Ӽ�Ҳ��Ƶ����Ļ�
               sprintf('����Ҫ��ĺ�ѡ��Ϊ:')
               output_set(code,Combinations(j,:))
               disp(Combinations(j,:))
                sprintf('��ѡ���Ӽ�')
                disp(nchoosek(Combinations(j,:),steps-1))
                % Calculate the support for the new itemset
                % ����ü��ϵ�֧�ֶ�
                % sum(transactions(:,Combinations(j,:)),2) ����ÿһ�е��ܺ�
                % disp(transactions(:,Combinations(j,:)))
                S = mean((sum(transactions(:,Combinations(j,:)),2)-steps)>=0);
                sprintf('�ú�ѡ����֧�ֶ�Ϊ%d',S)
                if S >= minSup
                    % ��ӵ�Ƶ�����
                    T = [T; Combinations(j,:)];
                    % Generate potential rules and check for minConf
                    for depth = 1:steps-1
                        R = nchoosek(Combinations(j,:),depth);
                        for r = 1:size(R,1)
                            if ct > nRules
                                break;
                            else
                                % Calculate the confidence of the rule
                                % �����������Ŷ�
                                Ctemp = S/mean((sum(transactions(:,R(r,:)),2)-depth)==0);
                                if Ctemp > minConf
                                    % b����ӵ����С֧�ֶȺ���С���ŶȵĹ���
                                    % Store the rules that have minSup and minConf
                                    Rules{1}{ct} = R(r,:);
                                    % setdiff(A,B������A�д��ڵ�B�в����ڵ�����
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
     % ����Ƶ���
    % Store the freqent itemsets
    FreqItemsets{steps} = T;
end


% ��ӡ�����е�Ƶ���
sprintf('��ӡ�����е�Ƶ���')
for i=1:size(FreqItemsets,2)
    sprintf('Ƶ��%d�',i)
    output_set(code,FreqItemsets{1,i});
end


% �ӵ�Ԥ����ʱ�������
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

disp(['���������㷨���,������Ϊ��' num2str(size(RuleSup,1))]);

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
disp(['�洢�����ļ���' rulesfile '�����'])
end