function [MostSimilar_value, MostSimalar_id] = calcMostSimilarSignatures(Msign, k, id)
   % Calculate the most similar signature

   similiarRow = sum(Msign(:,id) == Msign(:,:))/k;
   similiarRow(id) = 0; % delete similarity with me 
   [MostSimilar_value, MostSimalar_id] = max(similiarRow);
   
end

