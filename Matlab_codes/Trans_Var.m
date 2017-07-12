% ***************************************************** %
%             Laboratório de projetos 4                 %
% Function that get variables from matrix of alocations %
%      Inputs: Matrix of boxes, population size         %
%             Output: Population matrix                 %
% ***************************************************** %

function [nct, leastl] = Trans_Var(box_mat, MAL)
    
    % Get the number of container used by solution
    nct = max(MAL(:,1));
    
    % Initiating container load list
    loadList = zeros(nct, 1);
    
    % Find how full is each of the containers
    for i = 1:nct
        for k = 1:size(MAL, 1)
           if MAL(k, 1) == i
               loadList(i,1) = loadList(i,1) + box_mat(k, 1)*box_mat(k, 2)*box_mat(k, 3);
           end
        end
    end
    
    leastl = min(loadList);