function [s1_id, s2_id] = calc2MostSimilarSignatures(Msign, k, id)
    % Calculate the most similar signature

    similarityRow = sum(Msign(:,id) == Msign(:,:))/k;
    similarityRow(id) = 0; % delete similarity with me 
    
    % Find the first most similar signature
    [~, s1_id] = max(similarityRow);
    
    % Find the second most similar signature
    [~, s2_id] = max(similarityRow(similarityRow < max(similarityRow)));
end

