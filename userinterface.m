%% Ler estrutura

k = 200; % NOT CORRECT

load data/users.mat
load data/userSets.mat
load data/rest.mat
load data/MatrixSig.mat

%% ID do utilizador
% Validar ID
fprintf("\n")
Nu = length(users);
while true
    id = input(sprintf("Insert Tourist ID (1 to %d): ",Nu));
    if id > 0 && id <= length(users)
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
            % Restaurants evaluated by you (by ID)
            RestsEvaluated = userSets{id};
            fprintf("You evaluate %d restaurants.\n",length(RestsEvaluated));
            for r = RestsEvaluated'
                name = rest{r,2};
                location = rest{r,4};
                fprintf("[%d] - '%s', in %s\n",r,name,location);
            end

        case 2
            % Calculate the ~Jaccard distances
            [MostSimilar_value, MostSimalar_id] = calcMostSimilarSignatures(MatrixSig,k,id); 
            fprintf("Most Similar [ID=%d] - ~%.3f similar.\n",MostSimalar_id, MostSimilar_value);
            % Restaurants evaluated by Most Similar (by ID)
            RestsEvaluated = userSets{MostSimalar_id};
            for r = RestsEvaluated'
                name = rest{r,2};
                location = rest{r,4};
                fprintf("[%d] - '%s', in %s\n",r,name,location);
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