function MatrixSigShingles = createMatrixSignaturesWithStrings(stringSets, k)
    h= waitbar(0,"Creating Signatures...");

    Nu = length(stringSets);
    MatrixSigShingles = zeros(k, Nu);

    for u = 1:Nu 
        waitbar(u/Nu, h);
        string = stringSets{u};
        signature = zeros(1, k);    % store the MinHash of the current 'u'
        for i = 1:length(string)
            for fh = 1:k
                hc = string2hash(string{i});
                signature(fh) = min(hc);
            end
        end
        MatrixSigShingles(:, u) = signature';
    end

    delete(h);
end