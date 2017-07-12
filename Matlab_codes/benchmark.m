clc
clear all

% Problem data (box sizes)
% box_mat = [
% 47 31 13;
% 31 11 18;
% 16 99 84;
% 51 54 83;
% 33 45 11;
% 44 50 4;
% 18 39 13;
% 2 31 31;
% 1 1 17;
% 85 53 77;
% 14 22 38;
% 45 39 45;
% 24 33 33;
% 45 32 18;
% 90 82 6;
% 10 15 30;
% 9 22 32;
% 74 6 83;
% 73 10 68;
% 95 2 66;
% 3 20 26;
% 12 28 6;
% 79 73 39;
% 5 41 44;
% 21 8 21;
% 81 7 97;
% 24 50 11;
% 71 23 78;
% 88 64 86;
% 11 24 29;
% 13 1 25;
% 77 75 77;
% 98 81 27;
% 50 48 25;
% 7 30 22;
% 4 32 50;
% 36 14 40;
% 100 63 73;
% 21 50 44;
% 5 16 21;
% 30 5 48;
% 20 11 48;
% 90 97 50;
% 62 82 70;
% 13 5 22;
% 17 12 5;
% 38 45 50;
% 45 86 73;
% 2 45 43;
% 7 98 95;
% ];
bin_size = [250 130 100]; % Container size
pop_size = 50; % Population size (GA parameter)
t_mut = 0.05; % taxa de mutação
t_comb = 1; % taxa de combinação
t_elite = 0.2; % taxa de elitismo
n_ger = 80;
norients = 6;

[best_ind, best_MAL, best_fit] = GA(t_mut, t_comb, t_elite, box_mat, bin_size, pop_size, n_ger, norients)


fit_ideal = 1/(sum(box_mat(:,1).*box_mat(:,2).*box_mat(:,3))/(bin_size(1)*bin_size(2)*bin_size(3)))

aproveitamento = best_fit/fit_ideal

1/best_fit
