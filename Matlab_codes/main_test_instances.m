clc
%clear all

results = zeros(10,5);
for i = 1:10
% Problem data (box sizes)
    box_mat = instances{i};

    bin_size = [100 100 100]; % Container size
    pop_size = 50; % Population size (GA parameter)
    t_mut = 0.05; % taxa de mutação
    t_comb = 1; % taxa de combinação
    t_elite = 0.2; % taxa de elitismo
    n_ger = 100;
    norients = 6;

    %[best_ind, best_MAL, best_fit] = GA(t_mut, t_comb, t_elite, box_mat, bin_size, pop_size, n_ger);
    [best_ind, best_MAL, best_fit] = GA(t_mut, t_comb, t_elite, box_mat, bin_size, pop_size, n_ger, norients);

    fit_ideal = 1/(sum(box_mat(:,1).*box_mat(:,2).*box_mat(:,3))/(bin_size(1)*bin_size(2)*bin_size(3)));
    
    LMWideal = 1/fit_ideal;

    Aproveitamento = (best_fit/fit_ideal)*100;
    
    LMW = 1/best_fit;
    
    results(i,:) = [best_fit LMW Aproveitamento fit_ideal LMWideal]

end