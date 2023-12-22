function [s1_id, s2_id] = calc2MostSimilarSignatures(Msign, k, id)
    % Calcular assinaturas similares

    similarityRow = sum(Msign(:,id) == Msign(:,:))/k;
    similarityRow(id) = 0; % eliminar assinaturas
    
    % Esncontrar o mais similar
    [~, s1_id] = max(similarityRow);
    
    % Esncontrar o segundo mais similar
    [~, s2_id] = max(similarityRow(similarityRow < max(similarityRow)));
end

