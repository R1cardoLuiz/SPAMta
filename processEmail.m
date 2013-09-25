function word_indices = processEmail(vocabList, email_contents)
%PROCESSEMAIL preprocessa o corpo do email e retorna uma lista de word_indices
%


word_indices = [];


% Transforma todas as palavras em lowercase
email_contents = lower(email_contents);

% Remove todas as Tags HTML
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% Substitui todos os numeros por 'number'
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% remove urls e substitui por 'httpaddr'
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% remove endereços de email e substitui por 'emailaddr'
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% Remove sifrao por dolar
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== Tokeniza o Email ===========================

fprintf('\n==== Email Preprocessado ====\n\n');


l = 0;

while ~isempty(email_contents)

    % Tokeniza e remove pontuaçoes
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % Remove quaisquer caracteres nao alfanumericos
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % Faz o stemmer na palavra
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % Se a palavra for vazia, vai pra proxima palavra
    if length(str) < 1
       continue;
    end

    word_indices = [word_indices find(strcmp(vocabList, str))];

    % Exibe na tela o email
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;

end

fprintf('\n\n=========================\n');

end
