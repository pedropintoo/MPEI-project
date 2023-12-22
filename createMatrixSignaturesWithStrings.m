function Msign = createMatrixSignaturesWithStrings(countryShingles, k, M)
    % Cria a matriz de Assinaturas com k apartir de funcao
    % de dispersao, baseada na DJB31MA.
    h= waitbar(0,"Creating Signatures...");

    N = length(countryShingles); % número de países
    Msign = zeros(k, N);

    for u = 1:N 
        waitbar(u/N, h);

        setStrings = countryShingles{u};
        for fh = 1:k
            min = M; % hc \in [0,M-1]
            for idx = 1:length(setStrings)
                setStrings{idx} = [setStrings{idx} num2str(fh)];
                hc = DJB31MA(setStrings{idx},13);
                hc = mod(hc,M) + 1;
                if (hc < min)   % calculo do mínimo porque estamos a usar MinHash
                    min = hc;
                end
            end
            Msign(fh,u) = min;
        end
    end
    
    delete(h);
end