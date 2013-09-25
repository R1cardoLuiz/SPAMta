function [word_frq, freq] = buildVocabulary()
%BUILDVOCABULARY le todos os spam e cria um vocabulario com todas as palavras presentes em todos os spams
%
	clc; clear; close all;

	addpath(pwd);
	
    cd 'spam';
    email_array = {};
	
	%pega todos os emails na pasta spam
    spam_mails = getAllFiles('',0)';
    
    [rows cols] = size(spam_mails);	
	m_spam = rows;	
	%para cada spam, preprocesse
	for i = 1:m_spam
		filename = char(spam_mails(i));
		fprintf('Processando o email (%d/%d): %s\n', i, m_spam, filename);
		mail = readFile(filename);
		email_array = [email_array emailToWordArray(mail)];
    end
	
    %gera um array de palavras unicas
    uniqueNames = unique(email_array)';
	%procura a ocorrencia da palavra em todos os spams
    [~, uniq_id] = ismember(email_array, uniqueNames);
	%retorna a frequencia de cada palavra
    uniq_word_num = arrayfun(@(x) sum(uniq_id==x),1:numel(uniqueNames));
    
	%gera vetor com as palavras mais frequentes
    [freq, index] = sort(uniq_word_num, 'descend');
    
    word_frq = uniqueNames(index);
    
    cd ..

end