% ***************************************************** %
%             Laboratório de projetos 4                 %
%   Function that calculates Fitness for a chromosome   %
%      Inputs: Matrix of boxes, population size         %
%             Output: Population matrix                 %
% ***************************************************** %

function FaNB = Fitness_aNB(nct, leastl, bin_size)

    FaNB = 1/(nct - ( leastl / (bin_size(1)*bin_size(2)*bin_size(3))));