function [users, Sets] = createSets(filename)
    % Cria a estrutura de travels e turistas
    h=waitbar(0,'Creating Sets...');

    udata=load(filename);          
    u= udata(1:end,1:2); % apenas as duas primeiras colunas
    clear udata;
    
    users = unique(u(:,1));
    Nu= length(users); 

    % Conjunto de travels de cada turista
    Sets= cell(Nu,1);               
    
    for n = 1:Nu
        waitbar(n/Nu,h);
        ind = u(:,1) == users(n);
        Sets{n} = [Sets{n} u(ind,2)];
    end
    
    delete(h);
end