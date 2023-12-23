function [s1_id, s2_id] = calc2MostSimilarSignatures(Mdist, id)
    % Encontrar os 2 mais similares
    row = Mdist(id,:);
    
    % Esncontrar o mais similar
    [~,s1_id] = min(row);
    % Esncontrar o segundo mais similar
    [~,s2_id] = min(row(row > min(row)));

end

