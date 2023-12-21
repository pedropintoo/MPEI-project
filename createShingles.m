function countryShingles = createShingles(filename, k_shingle)

    countries = readcell(filename,'Delimiter',';');
    save("data/countries.mat","countries");
    
    numCountries = length(countries);
    
    countryShingles = cell(numCountries, 1);
    
    for i = 1:numCountries
        j = 1;
        name = countries{i,2};
        while (j+k_shingle-1 <= length(name))
            countryShingles{i}(j,1) = {name(j:j+k_shingle-1)};
            j = j + 1;
        end
    end
    
end