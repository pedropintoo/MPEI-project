%% Ler estrutura

k = 200; % NOT CORRECT

% bloom filter vars
load data/k_bloomFilter.mat
load data/v_bf.mat

% Matrix...
load data/travels.mat
load data/travelSets.mat
load data/travelSetsMoreThan3Days.mat
load data/MdistOption3.mat
load data/MdistOption4.mat

load data/travelInterests.mat
load data/countries.mat
load data/Msign.mat

%% ID do utilizador
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
            % Countries visited by current user (by ID)
            CountriesVisited = travelSets{id};
            fprintf("You visited %d countries.\n",length(CountriesVisited));
            for c = CountriesVisited'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s \n",c,name);
            end

        case 2
            % Calculate the ~Jaccard distances
            % s1 -> most similar | s2 -> second most similar
            [s1_id, s2_id] = calc2MostSimilarSignatures(Msign,k,id); 

            % this ID is not the tourists9.txt ID!!!
            s1_name = travelNames{travels(s1_id)}; % correct the ids!!!
            s2_name = travelNames{travels(s2_id)};
            fprintf("Countries evaluated by: [ID=%d,Name=%s] [ID=%d,Name=%s]\n",s1_id,s1_name,s2_id,s2_name);

            % Union of countries evaluated by the 2 most similar
            countriesEvaluated = union(travelSets{s1_id},travelSets{s2_id});
            for c = countriesEvaluated'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s \n",c,name); % e para imprimir so isto ????
            end
            
        case 3
            
            % Countries visited more than 3 days by current user (by ID)
            CountriesVisitedMoreThan3Days = travelSetsMoreThan3Days{id};

            CountriesVisited = travelSets{id}; % Para garantir que nao foram visitados
            
            DISTANCE = 1; ID = 2; % vars to use forther (to simplify)
            len = 0;
            for c = CountriesVisitedMoreThan3Days'
                [dist_sim,id_sim] = min(MdistOption3(c,:));
                % verificar se ja foi visitado
                if ismember(id_sim, CountriesVisited)
                    continue; % ja visitado
                end
                len = len + 1;
                similarC(len,DISTANCE) = dist_sim;
                similarC(len,ID) = id_sim; 
            end
                
            average = sum(similarC(:,DISTANCE))/len;
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
            % We are working with travels id's...
            [dist_sim,id_sim] = min(MdistOption4(travels(id),:)); % Atention: travels(id) !!!

            name = travelNames{id_sim};
            interests = travelInterests{id_sim};

            real_id = find(travels == id_sim); % inverse convertion!!!

            fprintf("The most similar turist: [ID=%d,Name=%s], with similarity ~%.2f\n",real_id,name,1-dist_sim); 
            fprintf("Interests: %s | %s | %s | %s | %s\n",interests{1},interests{2},interests{3},interests{4},interests{5}); 

        case 5
            % Countries visited by current user (by ID)
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