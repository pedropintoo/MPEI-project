function MatrixSigShingles = createMatrixSignaturesWithStrings(stringSets, k)
    h= waitbar(0,"Creating Signatures...");

    N = length(stringSets);
    MatrixSigShingles = zeros(k, N);

    for u = 1:N 
        waitbar(u/N, h);
        % x = stringSets{u}';
        x = cell2mat(stringSets{u}');
        
        for sh = 1:length(x)
            for fh = 1:k
                key = [x(sh) num2str(fh)];
                hc = string2hash(key);
                MatrixSigShingles(fh,u) = min(hc);
            end
        end
    end
    
    delete(h);
end