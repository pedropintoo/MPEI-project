function BloomFilterContagem = adicionarElementoContagem(BloomFilterContagem, elemento, v, k)
    % inserir elemento no BloomFilter, usando k funcoes de hash
    for fh = 1:k 
        % Carter and Wegman
        hc = mod(mod(v.a(fh).*elemento + v.b(fh) ,v.p),v.M);
        hc = mod(hc,length(BloomFilterContagem)) + 1; % queremos indices!
        BloomFilterContagem(hc) = BloomFilterContagem(hc) + 1;
    end
end

