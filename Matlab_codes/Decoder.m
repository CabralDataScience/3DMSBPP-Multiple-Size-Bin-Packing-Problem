% ***************************************************** %
%             Laborat�rio de projetos 4                 %
%     %
%      Inputs:         %
%             Output:                 %
% ***************************************************** %

function MAL = Decoder(phen, box_mat, bin_size)
    
    nb = length(phen)/2; % Number of boxes
    MAL = zeros(nb,5);    % Matriz de aloca��o
    btadd = ones(1,nb);  % Box to add
    ref = [0 0 0];       % Reference point
    bin = 1;             % Number of bins used
    layer_d = 0;         % Profundidade m�xima da layer atual
    layer_h = 0;         % Altura m�xima do layer atual
    
    % Se ela � igual a 1, � porque foi identificado que � poss�vel
    % acrescentar mais uma caixa no layer do bin. Se ela � igual a 
    % 0, � porque todas as caixas couberam no layer at� o momento.
    cabe_outra = 0;
    
    % Aplica a orienta��o nas caixas
    bmo = Orient_Boxes(phen, box_mat);   % Caixas orientadas
    
    while (any(btadd))
        
        %ref
        %cabe_outra
        %btadd
        %phen
        %bmo
        %MAL
        
        if (cabe_outra == 0)
            bi = find(btadd,1); % Box index inside box_to_add
        end
        
        box = phen(bi);
        
        % Cabe na refer�ncia?
        if ( all( ref+bmo(box,:) <= bin_size ) )
            
            MAL(box,:) = [bin phen(bi+nb) ref];
            ref(1) = ref(1)+bmo(box,1);
            btadd(bi) = 0;
            
            % Marcar Layer
            if ( bmo(box,2)>(layer_d) )
                layer_d = bmo(box,2);
            end
            if ( bmo(box,3)>(layer_h) )
                layer_h = bmo(box,3);
            end
            
            % Se veio de cabe outra
            if (cabe_outra == 1)
                % Pr�ximo bi n�o alocado
                values = find(btadd);
                bi = values(find(values>bi , 1));
                if (isempty(bi))
                    cabe_outra = 0;
                end
            end
            
        else
            
            %'N�o CABEEEEEEE'
            %bi
            
            % DEBUG
            if (bi == nb)
                cabe_outra = 0;
            end
            % DEBUG
            
            % Cabe alguma outra?
            for i = bi+1:nb
                if(all(ref+bmo(phen(i),:) <= bin_size) && (btadd(i)==1))
                    cabe_outra = 1;
                    bi = i;
                    %'Passou aqui'
                    break
                %DEBUG
                else
                    cabe_outra = 0;
                    %'Passou aqui DEBUG'
                %DEBUG
                end
            end
            
            % Abrir novo layer
            if (cabe_outra == 0)
                
                % Abre d
                ref(2) = ref(2) + layer_d;
                ref(1) = 0;
                % Cabe alguma no novo layer?
                for i = find(btadd,1):nb
                    if(all(ref+bmo(phen(i),:) <= bin_size) && (btadd(i)==1))
                        cabe_outra = 1;
                        bi = i;
                        break
                    end
                end
                
                %Abre novo layer em h
                if (cabe_outra == 0)
                    % Abre h
                    ref(3) = ref(3) + layer_h;
                    ref(2) = 0;
                    ref(1) = 0;
                    % Cabe alguma no novo layer?
                    for i = find(btadd,1):nb
                        if(all(ref+bmo(phen(i),:) <= bin_size) && (btadd(i)==1))
                            cabe_outra = 1;
                            bi = i;
                            break
                        end
                    end
                end
                
                % Abre novo bin
                if (cabe_outra == 0)
                    bin = bin + 1;
                    ref = [0 0 0];
                end
            end
            
        end
    end