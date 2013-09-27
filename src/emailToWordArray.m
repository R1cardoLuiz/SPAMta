function [email_array] = emailToWordArray(email_contents)

email_array = {};

email_contents = lower(email_contents);

email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

email_contents = regexprep(email_contents, '[0-9]+', 'number');

email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

email_contents = regexprep(email_contents, '[$]+', 'dollar');


while ~isempty(email_contents)

    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    if length(str) < 1
       continue;
    end
    
    email_array = [email_array str];


end

    
end

