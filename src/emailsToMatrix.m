function [X y] = emailsToMatrix()
%EMAILSTOMATRIX Gera matriz de features onde cada linha e um email
%
	clc; clear; close all;
	old_path = path;
	addpath(pwd);
	load('vocabulary_complete.mat');
    vocabList = sort(word_frq(1:2000));
	tic
	cd 'spam';
	X_spam = [];
	spam_mails = getAllFiles('',0)'
	[rows cols] = size(spam_mails);	
	m_spam = rows;	
	for i = 1:m_spam
		filename = char(spam_mails(i));
		fprintf('Processando os spam(%d/%d): %s\n', i, m_spam, filename);
		mail = readFile(filename);
		word_indices  = processEmail(vocabList, mail);
		features = emailFeatures(word_indices);
		X_spam = [X_spam; features'];		
	end
	y_spam = ones(m_spam,1);
	cd ..	
	
	%%
	cd 'ham';
	X_nonspam = [];
	nonspam_mails = getAllFiles('',0)'
	[rows cols] = size(nonspam_mails);	
	m_nonspam = rows;
	for i = 1:m_nonspam
		filename = char(nonspam_mails(i));
		fprintf('Processando os ham(%d/%d): %s\n', i, m_nonspam, filename);
		mail = readFile(filename);
		word_indices  = processEmail(vocabList, mail);
		features = emailFeatures(word_indices);
		X_nonspam = [X_nonspam; features'];		
	end
	y_nonspam = zeros(m_nonspam,1);
	cd ..
	path(old_path);
	elapsed = toc
	
	fprintf ('A total of %d/%d spam/non-spam emails processados.\n', m_spam, m_nonspam);
	fprintf ('Tempo gasto: %f (%f seg cada sample).\n', elapsed, elapsed/(m_spam+m_nonspam));
	X = [X_spam; X_nonspam];
	y = [y_spam; y_nonspam];
	save('spamAssassin_corpus', 'X','y');
end