function countryShingles = createShingles(filename, k_shingle)
    
    % ler o ficheiro para guardar os países
    countries = readcell(filename,'Delimiter',';');
    save("data/countries.mat","countries");
    
    numCountries = length(countries);   % número de países
    
    % estrutura para guardar os shingles da descrição
    countryShingles = cell(numCountries, 1);
    
    for i = 1:numCountries
        j = 1;
        name = countries{i,2};
        while (j+k_shingle-1 <= length(name))
            countryShingles{i}(j,1) = {name(j:j+k_shingle-1)};
            j = j + 1;
        end

        countryShingles{i} = unique(countryShingles{i}); % shingles nao se repetem
    end
    
end