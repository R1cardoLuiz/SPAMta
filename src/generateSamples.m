function [samples] = generateSamples()
% GENERATESAMPLES divide o conjunto de dados aleatoriamente em 
%  conjunto de treino, teste e cross validation

	load('spamAssassin_corpus.mat');
	[samps, feats] = size(X);
	
	percent_train = 0.7;
	percent_cv = 0.15;
	
	m = size(y,1);
	train_ind = floor(percent_train * m);
	cv_ind = floor(percent_cv * m);
	
	permute = randperm(m)';
	X_perm =  X(permute,:);
	y_perm = y(permute);
	
	samples.X_train = X_perm(1:train_ind,:);
	samples.y_train = y_perm(1:train_ind);
	
	samples.X_cv = X_perm(train_ind+1:train_ind+cv_ind,:);
	samples.y_cv = y_perm(train_ind+1:train_ind+cv_ind);
	
	samples.X_test = X_perm(train_ind+cv_ind+1:m,:);
	samples.y_test = y_perm(train_ind+cv_ind+1:m);
end