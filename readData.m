% utilizadores - ID
% restaurantes - ID

% 'turistas1.data'
% id-turista | id-restaurante | ... | score
[users, userSets] = createSets('data/turistas1.data');

save("data/users.mat","users");
save("data/userSets.mat","userSets");

k = 200;
N = 1e7;

% iniciar as funções de dispersão
v = initHashFunctions(N, k);

% calcular a Matriz de Assinaturas com MinHash
MatrixSig = createMatrixSignatures(userSets, v, k);
%disp(MatrixSig);

save("data/MatrixSig.mat", "MatrixSig");


% 'restaurantes.txt'
% id-restaurante | nome | localidade | concelho | tipo cozinha | prato recomendado | dias encerrado
k_shingle = 3;
restShingles = createShingles('data/restaurantes.txt',k_shingle);

k = 200;
N = 1e7;

%  ... temos de utilizar outras funcoes (criar novas) porque agora tamos 
% a trabalhar com strings

createMatrixSignaturesWithShingles(restShingles,k);
