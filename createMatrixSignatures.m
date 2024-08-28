function Msign = createMatrixSignatures(Sets, v, k)
    % Cria a matriz de Assinaturas com k apartir de funcao
    % de dispersao, baseada na familia universal
    % com o Metodo de Carter and Wegman
    % h(x) = ((ax + b) mod p) mod M
    % p primo: p >= M, a \in (1,p-1), b \in (0,p-1)
    h= waitbar(0,"Creating Signatures...");

    N = length(Sets);
    Msign = zeros(k, N);

    for u = 1:N 
        waitbar(u/N, h);
        x = Sets{u}';
        for fh = 1:k
            % Metodo de Carter and Wegman 
            Msign(fh,u) = min(mod(mod(v.a(fh).*x + v.b(fh) ,v.p),v.M));
        end
    end
    
    delete(h);
end