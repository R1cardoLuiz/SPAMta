function file_contents = readFile(filename)
%READFILE le o arquivo e retorna o conteudo do email

fid = fopen(filename);
if fid
    file_contents = fscanf(fid, '%c', inf);
    fclose(fid);
else
    file_contents = '';
    fprintf('Erro ao abrir %s\n', filename);
end

end

