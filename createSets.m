function [users, Sets, moreThan3Days] = createSets(filename)
    % Cria a estrutura de filmes e utilizadores
    h=waitbar(0,'Creating Sets...');

    udata=load(filename);          
    u= udata(1:end,1:3); % apenas as 3 primeiras colunas
    clear udata;
    
    users = unique(u(:,1));
    % users = users(randperm(length(users),100)); % exercicio 2
    Nu= length(users); 

    % Consjunto de filmes avaliados para cada utilizador
    Sets= cell(Nu,1); 
    moreThan3Days= cell(Nu,1);
    
    for n = 1:Nu % para cada utilizador 
        waitbar(n/Nu,h);
        ind1 = u(:,1) == users(n);
        Sets{n} = [Sets{n} u(ind1,2)];
        ind2 = (u(:,1) == users(n)) & (u(:,3) > 3);
        moreThan3Days{n} = [moreThan3Days{n} u(ind2,2)];
    end
    
    delete(h);
end