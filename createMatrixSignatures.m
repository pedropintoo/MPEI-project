function MatrixSignatures = createMatrixSignatures(userSets, v, k)
    % Cria a matriz de Assinaturas com k apartir de funcao
    % de dispersao, baseada na familia universal
    % com o Metodo de Carter and Wegman
    % h(x) = ((ax + b) mod p) mod M
    % p primo: p >= M, a \in (1,p-1), b \in (0,p-1)
    h= waitbar(0,"Creating Signatures...");

    Nu = length(userSets);
    MatrixSignatures = zeros(k, Nu);

    for u = 1:Nu 
        waitbar(u/Nu, h);
        x = userSets{u}';
        for fh = 1:k
            % Metodo de Carter and Wegman 
            MatrixSignatures(fh,u) = min(mod(mod(v.a(fh).*x + v.b(fh) ,v.p),v.M));
        end
    end
    
    delete(h);
end