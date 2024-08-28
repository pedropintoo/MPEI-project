function count = contagemElemento(BloomFilterContagem, elemento, v, k)
    % devolve a menor contagem de um membro do BloomFilter

    % Carter and Wegman
    hc = mod(mod(v.a(1).*elemento + v.b(1) ,v.p),v.M);
    hc = mod(hc,length(BloomFilterContagem)) + 1; 
    count = BloomFilterContagem(hc);

    for fh = 2:k
        % Carter and Wegman
        hc = mod(mod(v.a(fh).*elemento + v.b(fh) ,v.p),v.M);
        hc = mod(hc,length(BloomFilterContagem)) + 1; 

        c = BloomFilterContagem(hc);
        if c == 0
            count = 0;
            break; % nao é membro!
        elseif c < count
            count = c;
        end 
    end 

end
