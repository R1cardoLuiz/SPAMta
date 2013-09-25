

%% Limpa todas as variaveis e a tela
clear ; close all; clc
%%
load('vocabulary_complete.mat');
vocabList = sort(word_frq(1:2000));

%% exemple de um email preprocessado

fprintf('\nPreprocessando o email (emailSample1.txt)\n');

% Extrai as features
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(vocabList, file_contents);

fprintf('Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');


%% treina SVM e calcula a precisao
clc;
fprintf('\nUsando SVM do MATLAB\n')

[samples] = generateSamples();

xTrain = samples.X_train;
yTrain = samples.y_train;

xCv = samples.X_cv;
yCv = samples.y_cv;

xTest = samples.X_test;
yTest = samples.y_test;

svmStruct = svmtrain(xTrain, yTrain);

fprintf('\nTreina o SVM usando o conjunto de treinamento xTrain ...\n')

pTrain = svmclassify(svmStruct, xTrain);

fprintf('Precisão: %f\n', mean(double(pTrain == yTrain)) * 100);

fprintf('\nAvalia o cross validation ...\n')

pCv = svmclassify(svmStruct, xCv);

fprintf('Precisão: %f\n', mean(double(pCv == yCv)) * 100);

fprintf('\nAvalia o test set ...\n')

pTest = svmclassify(svmStruct, xTest);

fprintf('Precisão: %f\n', mean(double(pTest == yTest)) * 100);


%%
clc;
filename = 'emailSample2.txt';

file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);


fprintf('\nTAM: %d\n', size(x));

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);

%%
filename = 'spamSample1.txt';

file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);


%%
filename = 'spamSample2.txt';

file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);


%%
filename = 'spamSample3.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);

%%
filename = 'spamSample4.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);

%%
filename = 'emailSample1.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);

%%
filename = 'emailSample2.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);


%%
filename = 'spamTest.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);


%%
filename = 'hamTest.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);


%%
filename = 'testeSample.txt';
p = 0;
file_contents = readFile(filename);
word_indices  = processEmail(vocabList, file_contents);
x             = emailFeatures(word_indices);

p = svmclassify(svmStruct, x');

fprintf('\nEmail:  %s\nClassificacao:  %d\n', filename, p);

