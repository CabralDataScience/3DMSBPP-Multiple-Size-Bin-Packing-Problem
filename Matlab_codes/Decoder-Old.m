function alocation_matrix = Decoder_Old(phenotype, box_mat, bin_size)

n = size(phenotype,2)/2; % número de caixas

% cria matriz de caixas orientadsa
or_box_mat = Orient_Boxes(phenotype,box_mat)

% inicia lista EMS
listEMS = {[0 0 0 bin_size]};

% inicia matriz de alocação
alocation_matrix = zeros(n,5);

% para cada caixa encontra o melhor EMS e aloca a caixa naquela posição
for i = 1:n
   box = box_mat(phenotype(1,i),:);
   best_bin = 0;
   best_EMS = 0;
   bigger_dist = 0;
   nc = size(listEMS);
   for j = 1:nc
      nEMS = size(listEMS{j},1);
      for k = 1:nEMS
         if(listEMS{j}(1,4)>box(1) && ...
               listEMS{j}(1,5)>box(2) && listEMS{j}(1,6)>box(3))
            dist = sqrt((listEMS{j}(k,[1 2 3])-bin_size).^2);
            if(dist>bigger_dist)
               best_bin = j;
               best_EMS = k;
               bigger_dist = dist;
            end
         end
      end
   end
   
   % se não encontrou nenhum EMS que caiba a caixa, abre um novo bin
   if(bigger_dist == 0) 
      new_bin = length(ListEMS)+1;
      ListEMS{new_bin} = {[0 0 0 bin_size]};
      best_bin = new_bin;
      best_EMS = 1;
   end
   
   % aloca caixa no melhor EMS encontrado
   alocation_matrix(phenotype(i),:) = ...
      [best_bin phenotype(i+n) listEMS{best_bin}(best_EMS, [1 2 3])];

   %TODO: Calcular novos EMSs
   
   %TODO: Atualizar ListaEMS   
   
end   
