% 'travelsN.data'
% id-travel | id-country que visitou |  | ... | score
[travels, travelSets, travelSetsMoreThan3Days] = createSets('data/travels9.data');

save("data/travels.mat","travels");
save("data/travelSets.mat","travelSets");
save("data/travelSetsMoreThan3Days.mat","travelSetsMoreThan3Days")

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
travelNames = dic(:,2:3);
save("data/travelNames.mat","travelNames");
travelInterests = cell(length(dic), 1);
for t = 1:length(dic)
    travelInterests{t} = dic(t,4:8)';
end

save("data/travelInterests.mat","travelInterests");

%% Option 3

% 'countries_info.csv.txt'
% id-country | description
k_shingle = 8; %% ???
countryShingles = createShingles('data/countries_info.csv', k_shingle); % shinglesDescription


k = 50; % ???
M = 1e6; % Hash values mod

% calcular a Matriz de Assinaturas com MinHash
MsignShi = createMatrixSignaturesWithStrings(countryShingles, k, M);

%% Calculate the distances

MdistOption3 = calcDistancesSignatures(MsignShi,k);
save('data/MdistOption3.mat',"MdistOption3");

%% Option 4





%% Option 5

N = 1e4;
k_bloomFilter = 10; 
save("data/k_bloomFilter.mat","k_bloomFilter");
BloomFilterContagem = inicializarFiltroContagem(N);

udata=load('data/travels9.data');          
visitedCountries = udata(:,2); % with repetition!
clear udata;

% iniciar as funções de dispersão
v_bf = initHashFunctions(N, k_bloomFilter);
save("data/v_bf.mat","v_bf"); % guardo para depois puder utilizar na contagem

for i = 1:length(visitedCountries)
    BloomFilterContagem = adicionarElementoContagem(BloomFilterContagem, visitedCountries(i), v_bf, k_bloomFilter);
end

save("data/BloomFilterContagem.mat","BloomFilterContagem");

