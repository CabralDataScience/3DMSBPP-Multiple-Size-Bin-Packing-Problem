clc
clear all

% Problem data (box sizes)
box_mat = [10 20 15; 
           20 10 15;
           10 20 15;
           20 10 15;
           10 20 15;
           10 20 15;
           20 10 15;
           20 10 15;
           20 10 15;        ];

% Test data (since alocation is not working properly)
% MAL = [2 1 10 10 10; 
%        1 1 10 10 10;
%        3 1 10 10 10;
%        2 1 10 10 10;
%        1 2 10 10 10;
%        2 2 10 10 10;
%        1 2 10 10 10;
%        2 1 10 10 10;
%        3 2 10 10 10;       ];

% Container size
bin_size = [100 20 100];

% Population size (GA parameter)
p = 5;

% Generates population matrix (Packing sequence ordered)
pop = BiasedKey(box_mat, p);

MAL = Decoder2(pop(1,:),box_mat,bin_size)

% for i = 1:p
%     
%     % Alocate the boxes into the containers (not working)
%     %MAL = Decoder(pop(i,:), box_mat, bin_size);
% 
%     % Get variables to calculate Fitness
%     [nct, leastl] = Trans_Var(box_mat, MAL);
% 
%     % Get the fitness value for the solution
%     FaNB(i) = Fitness_aNB(nct, leastl, bin_size);
% 
% end

% FaNB