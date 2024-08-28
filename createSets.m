function [users, Sets, moreThan3Days] = createSets(filename)
    h=waitbar(0,'Creating Sets...');

    udata=load(filename);          
    u= udata(1:end,1:3); % apenas as 3 primeiras colunas
    clear udata;
    
    users = unique(u(:,1));
    Nu= length(users); 

    % Conjunto para guardar as viagens de cada turista
    Sets= cell(Nu,1); 

    % Conjunto para guardar as viagens de cada turista que visitou por mais
    % de 3 dias
    moreThan3Days= cell(Nu,1);
    
    for n = 1:Nu
        waitbar(n/Nu,h);
        
        ind1 = u(:,1) == users(n);
        Sets{n} = [Sets{n} u(ind1,2)];

        ind2 = (u(:,1) == users(n)) & (u(:,3) > 3);
        moreThan3Days{n} = [moreThan3Days{n} u(ind2,2)];
    end
    
    delete(h);
end