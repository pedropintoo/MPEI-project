%% Ler estrutura

k = 200; % NOT CORRECT

load data/travels.mat
load data/travelSets.mat
load data/travelInterests.mat
load data/countries.mat
load data/Msign.mat
load data/M2mostSim.mat


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
            s1_id = M2mostSim(id,1);
            s2_id = M2mostSim(id,2);
            fprintf("Countries evaluated by: [ID=%d] [ID=%d]\n",s1_id,s2_id);
            % Union of countries evaluated by the 2 most similar
            countriesEvaluated = union(travelSets{s1_id},travelSets{s2_id});
            for c = countriesEvaluated'
                name = countries{c,1};
                fprintf("[ID=%3d] - %s \n",c,name); % e para imprimir so isto ????
            end
            
        case 3
            searchRestaurant(id_rest);
        case 4
            mostSimilarRestaurants(id_rest);
        case 5
            restaurantsEvaluatedById(id_rest);
            break
        case 6
            fprintf("Good bye :)\n");
            return  
    end
end