%% Globais
% cálculo dos Sets relativos às viagens 
[travels, travelSets, travelSetsMoreThan3Days] = createSets('data/travels9.data');

% guardar na pasta data para depois ser usado em 'main.m'
save("data/travels.mat","travels");
save("data/travelSets.mat","travelSets");
save("data/travelSetsMoreThan3Days.mat","travelSetsMoreThan3Days")

dic = readcell('data/tourists9.txt','Delimiter',';');
% guardar apenas o primeiro e último nome de cada turista
travelNames = dic(:,2:3);

% guardar na pasta data para depois ser usado em 'main.m'
save("data/travelNames.mat","travelNames");

% guardar os interesses de cada turista
travelInterests = cell(length(dic), 1);
for t = 1:length(dic)
    travelInterests{t} = dic(t,4:8)';
end

% guardar na pasta data para depois ser usado em 'main.m'
save("data/travelInterests.mat","travelInterests");


%% Opcao 2

k = 200; %% ???
N = 1e7; %% ???

% iniciar as funções de dispersão
v = initHashFunctions(N, k);

% calcular a Matriz de Assinaturas com MinHash das viagens
Msign = createMatrixSignatures(travelSets, v, k);

% Calcular as distâncias de Jaccard
MdistOption2 = calcDistancesSignatures(Msign,k);
save('data/MdistOption2.mat',"MdistOption2");

%% Opçao 3

k_shingle = 8; %% ???

% criar uma estrutura com as descrições de cada país em shingles
% guarda data/countries.mat
countryShingles = createShingles('data/countries_info.csv', k_shingle); % shinglesDescription

k = 25; % ???
M = 1e6; % Hash values mod

% calcular a Matriz de Assinaturas com MinHash combinando shingles
MsignShi = createMatrixSignaturesWithStrings(countryShingles, k, M);

% Calcular as distâncias de Jaccard
MdistOption3 = calcDistancesSignatures(MsignShi,k);
save('data/MdistOption3.mat',"MdistOption3");

%% Opçao 4

k = 200; % ???
M = 1e6; % Hash values mod

% calcular a Matriz de Assinaturas com MinHash dos interesses
MsignInt = createMatrixSignaturesWithStrings(travelInterests, k, M);

% Calcular as distâncias de Jaccard
MdistOption4 = calcDistancesSignatures(MsignInt,k);
save('data/MdistOption4.mat',"MdistOption4");


%% Opçao 5

N = 1e4;
k_bloomFilter = 20;     % k funções de dispersão 
save("data/k_bloomFilter.mat","k_bloomFilter");

% inicializar o Counting Filter Bloom
BloomFilterContagem = inicializarFiltroContagem(N);

udata=load('data/travels9.data');          
visitedCountries = udata(:,2);  % com repetição!
clear udata;

% iniciar as funções de dispersão
v_bf = initHashFunctions(N, k_bloomFilter);
save("data/v_bf.mat","v_bf"); % guarda para depois puder utilizar na contagem

for i = 1:length(visitedCountries)
    BloomFilterContagem = adicionarElementoContagem(BloomFilterContagem, visitedCountries(i), v_bf, k_bloomFilter);
end

save("data/BloomFilterContagem.mat","BloomFilterContagem");

