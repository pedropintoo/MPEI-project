% 'travelsN.data'
% id-travel | id-country que visitou |  | ... | score
[travels, travelSets] = createSets('data/travels9.data');

save("data/travels.mat","travels");
save("data/travelSets.mat","travelSets");

k = 200; %% ???
N = 1e7; %% ???

% iniciar as funções de dispersão
v = initHashFunctions(N, k);

% calcular a Matriz de Assinaturas com MinHash
Msign = createMatrixSignatures(travelSets, v, k);
save("data/Msign.mat", "Msign");

%%
% 'tourists9.txt'
% id-travel | name | surname | interest1 | interest2 | ...
dic = readcell('data/tourists9.txt','Delimiter',';');
travelInterests = dic(:,4:8);
save("data/travelInterests.mat","travelInterests");

%%
% 'countries_info.csv.txt'
% id-country | description
k_shingle = 8; %% ???
countryShingles = createShingles('data/countries_info.csv',k_shingle); % shinglesDescription

% k = 200; %% ???
% N = 1e7; %% ???

%% Option 2

% Calcular as 2 assinaturas mais similares de cada turista
Nt = length(travels);
M2mostSim = zeros(t,2);
for t = 1:Nt
    [a,b] = calc2MostSimilarSignatures(Msign,k,t);
    M2mostSim(t,1) = a;
    M2mostSim(t,2) = b;
end
save("data/M2mostSim.mat", "M2mostSim");
