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
            CMT3D = length(CountriesVisitedMoreThan3Days);
            similarC = zeros(CMT3D,2);
            DISTANCE = 1; ID = 2; % vars to use forther (to simplify)
            i = 1;
            for c = CountriesVisitedMoreThan3Days'
                [similarC(i,DISTANCE), similarC(i,ID)] = min(MdistOption3(c,:));
                i = i + 1;
            end
            % Pode acontecer ja terem sido visitados!
            % ||||||||||||||||||||||||||||||||||||||||||||
            threshold = sum(similarC(:,DISTANCE))/CMT3D;
            for c = similarC'
                distance = c(DISTANCE);
                if distance >= threshold
                    continue;
                end
                id = c(ID);
                name = countries{id,1};
                fprintf("[ID=%3d] - %s, with distance ~%.2f\n",id,name,distance);
            end
           
        case 4
            mostSimilarRestaurants(id_rest);
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