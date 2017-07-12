% ***************************************************** %
%             Laboratório de projetos 4                 %
%   Function that implements the Biased Key Algorithm   %
%      Inputs: Matrix of boxes, population size         %
%             Output: Population matrix                 %
% ***************************************************** %

function pop = BiasedKey(box_mat, p, norients)
    
    n = length(box_mat); % Number of boxes
    
    % Generate keys
    keys = rand(p, n);
    
    % Order keys and form population matrix
    [keys pop] = sort(keys, 2);
    
    % Generate random orientation
    % OBS: ONLY generating 1 or 2 for now
    orients = rand(p, n)*(norients-1);
    orients = round(orients) + 1;
    
    % Form the final population matrix
    pop = [pop orients];