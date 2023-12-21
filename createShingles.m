function restShingles = createShingles(filename, k_shingle)

    rest = readcell(filename,'Delimiter','\t');
    save("data/rest.mat","rest");
    
    numRests = length(rest);
    
    restShingles = cell(numRests, 1);
    
    for i = 1:numRests
        j = 1;
        name = rest{i,2};
        while (j+k_shingle-1 <= length(name))
            restShingles{i}(j,1) = {name(j:j+k_shingle-1)};
            j = j + 1;
        end
    end
    
end