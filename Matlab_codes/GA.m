function [best_ind, best_MAL, best_fit] = GA(t_mut, t_comb, t_elite, box_mat, bin_size, pop_size, n_ger, norients)
% t_elite n�o pode ser maior que 49%


    pop = BiasedKey(box_mat, pop_size, norients);
    gen_size = size(pop,2);
    new_pop = zeros(pop_size, gen_size);
    elitep = round(pop_size*t_elite);
    if(mod(elitep,2) == 1)
       elitep = elitep-1; 
    end
    randp = pop_size - 2*elitep;
    
    for i = 1:n_ger
        
        fitness = zeros(1,pop_size);
        
        for j = 1:pop_size
            
            MAL = Decoder(pop(j,:),box_mat,bin_size);
            [nct, leastl] = Trans_Var(box_mat, MAL);
            fitness(j) = Fitness_aNB(nct, leastl, bin_size);
                        
        end       
        % Sele��o
        % Melhores indiv�duos (Elitismo)
        [~ ,I] = sort(fitness,'descend');
        new_pop(1:elitep,:) = pop(I(1:elitep),:);
        
        % Gera��o descendente
        for k = 1:2:elitep
            
            % Combina��o
            % A combina��o � feita somente na parte VBO do gene e se um
            % n�mero aleat�rio gerado for menor que a taxa de combina��o
            % t_comb.
            new_pop(k+elitep,1:gen_size/2) = new_pop(k,1:gen_size/2);
            new_pop(k+elitep+1,1:gen_size/2) = new_pop(k+1,1:gen_size/2);
            if(rand <= t_comb)
                cut_point = round(rand*(gen_size/2));
                new_pop(k+elitep,(gen_size/2)+1:end) = ...
                    [new_pop(k,(gen_size/2)+1:gen_size/2+cut_point), ...
                     new_pop(k+1,gen_size/2+cut_point+1:end)];
                 new_pop(k+1+elitep,(gen_size/2)+1:end) = ...
                    [new_pop(k+1,(gen_size/2)+1:gen_size/2+cut_point), ...
                     new_pop(k,gen_size/2+cut_point+1:end)];
            else
                new_pop(k+elitep,(gen_size/2)+1:end) = ...
                    new_pop(k,(gen_size/2)+1:end);
                new_pop(k+1+elitep,(gen_size/2)+1:end) = ...
                    new_pop(k+1,(gen_size/2)+1:end);
            end
            
            %Muta��o
            % A muta��o � feita somente na parte BPS do gene e se um
            % n�mero aleat�rio gerado for menor que a taxa de muta��o
            % t_mut.
            
            for m = 1:gen_size/2
                % Descendente 1
                if(rand <= t_mut)
                    go_to = round(rand*((gen_size/2)-1))+1;
                    aux = new_pop(k+elitep, go_to);
                    new_pop(k+elitep, go_to) = new_pop(k+elitep, m);
                    new_pop(k+elitep, m) = aux;
                end
                
                % Descendente 2
                if(rand <= t_mut)
                    go_to = round(rand*((gen_size/2)-1))+1;
                    aux = new_pop(k+1+elitep, go_to);
                    new_pop(k+1+elitep, go_to) = new_pop(k+1+elitep, m);
                    new_pop(k+1+elitep, m) = aux;
                end
            end 
        end
        
        % Complemento de popula��o
        % O restante da popula��o � gerado aleatoriamente.
        new_pop(2*elitep+1:end,:) = BiasedKey(box_mat, randp, norients);
        
        % Atualiza popula��o
        pop = new_pop; 
        
        bfprint = max(fitness);
        fprintf('Fitness: %d Gera��o: %d LMW: %d\n', bfprint, i,ceil(1/bfprint));
    end
    
    best_fit = 0;
    fitness = zeros(1,pop_size);  
    for j = 1:pop_size
        MAL = Decoder(pop(j,:),box_mat,bin_size);
        [nct, leastl] = Trans_Var(box_mat, MAL);
        fitness(j) = Fitness_aNB(nct, leastl, bin_size);
        if(fitness(j) > best_fit)
            best_fit = fitness(j);
            best_ind = pop(j,:);
            best_MAL = MAL;
            
        end        
    end 
end