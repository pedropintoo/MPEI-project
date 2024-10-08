%% Ler ficheiros

% Globais
load data/travels.mat
load data/travelSets.mat
load data/travelNames.mat
load data/travelInterests.mat
load data/travelSetsMoreThan3Days.mat

load data/countries.mat

% Matrizes de distancias por Opçoes
load data/MdistOption2.mat
load data/MdistOption3.mat
load data/MdistOption4.mat

% Counter Bloom Filter (opcao 5)
load data/k_bloomFilter.mat             % k funcoes de hash do Bloom Filter
load data/v_bf.mat                      % funcoes de hash utilizadas para adicionar/contar no Bloom Filter
load data/BloomFilterContagem.mat   


%% ID do turista
% Validar ID
fprintf("\n")
Nu = length(travels);
while true
    id = input(sprintf("Insert Tourist ID (1 to %d): ",Nu));
    if id > 0 && id <= length(travels)
        break;
    end
end

%% Opcoes a executar

while true
    option = input("\n1 - Countries (or regions) visited by current user.\n" + ...
          "2 - Set of countries evaluated by the 2 more similar users.\n" + ...
          "3 - Suggestion of countries to visit.\n" + ...
          "4 - Suggestion of similar tourists based on interests.\n" + ...
          "5 - Estimate total of visits to the countries visited by current user.\n" + ...
          "6 - Exit\n" + ...
          "Select choice: ");
    fprintf("\n");
    switch option
        case 1
            % Paises visitados do id
            CountriesVisited = travelSets{id};
            fprintf("You visited %d countries.\n",length(CountriesVisited));
            for c = CountriesVisited'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s \n",c,name);
            end

        case 2
            % Calcular as distâncias de Jaccard
            % s1 -> mais similar | s2 -> segundo mais similar
            [s1_id, s2_id] = calc2MostSimilarSignatures(MdistOption2,id); 

            % o ID não está presente em tourists9.txt ID!!!
            s1_name = travelNames{travels(s1_id)}; % IDs corretos!!!
            s2_name = travelNames{travels(s2_id)};
            fprintf("Countries evaluated by: [ID=%d,Name=%s] [ID=%d,Name=%s]\n",s1_id,s1_name,s2_id,s2_name);

            % União dos países 
            countriesEvaluated = union(travelSets{s1_id},travelSets{s2_id});
            for c = countriesEvaluated'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s \n",c,name); % e para imprimir so isto ????
            end
            
        case 3
            % Países visitados por mais de 3 dias
            CountriesVisitedMoreThan3Days = travelSetsMoreThan3Days{id};

            CountriesVisited = travelSets{id}; % Para garantir que nao foram visitados
            
            DISTANCE = 1; ID = 2; % constantes
            idx = 1;
            for c = CountriesVisitedMoreThan3Days'
                [dist_sim,id_sim] = min(MdistOption3(c,:));
                % verificar se ja foi visitado
                if ismember(id_sim, CountriesVisited)
                    continue; % ja visitado
                end
                similarC(idx,DISTANCE) = dist_sim;
                similarC(idx,ID) = id_sim; 
                idx = idx + 1;
            end
                
            average = mean(similarC(:,DISTANCE));
            fprintf("Suggestion of countries to visit with ~distance < %.2f\n",average);
            for c = similarC'
                distance = c(DISTANCE);
                if distance >= average
                    continue;
                end
                id_c = c(ID);
                name = countries{id_c,1};
                fprintf("[ID=%3d] - %s, with distance ~%.2f\n",id_c,name,distance);
            end
           
        case 4
            % Estamos a trabalhar com id's dos travels ([1,2000]) !!!
            [dist_sim,id_sim] = min(MdistOption4(travels(id),:));

            name = travelNames{id_sim}; % nao precisamos de conversao
            interests = travelInterests{id_sim};

            real_id = find(travels == id_sim); % conversao para ter o verdadeiro ID

            fprintf("The most similar turist: [ID=%d,Name=%s], with similarity ~%.2f.\n",real_id,name,1-dist_sim); 
            fprintf("Interests: %s | %s | %s | %s | %s\n",interests{1},interests{2},interests{3},interests{4},interests{5}); 

        case 5
            % Paises visitados pelo o ID
            CountriesVisited = travelSets{id};
            fprintf("You visited %d countries.\n",length(CountriesVisited));
            for c = CountriesVisited'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s, visited ~%d times\n",c,name,contagemElemento(BloomFilterContagem,c,v_bf,k_bloomFilter));
            end
        case 6
            fprintf("Good bye :)\n");
            return  
    end
end