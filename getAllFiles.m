function fileList = getAllFiles(dirName, recurse)
%GETALLFILES pega todos os arquivos de um diretorio
%
	if ( (strcmp(dirName, '') == 1) || (strcmp(dirName, '\') == 1) || (strcmp(dirName, '\\') == 1) )
		dirName = '.';
	end
	dirData = dir(dirName);     
	dirIndex = [dirData.isdir];
	fileList = {dirData(~dirIndex).name}; 
	if ~isempty(fileList)
		fileList = cellfun(@(x) fullfile(dirName,x), fileList,'UniformOutput',false); 
	end
	
	if (recurse == 1 || recurse == true)
		subDirs = {dirData(dirIndex).name}; 
		validIndex = ~ismember(subDirs,{'.','..'});  
										
		for iDir = find(validIndex)                  
			nextDir = fullfile(dirName,subDirs{iDir}); 
			fileList = [fileList; getAllFiles(nextDir,1)];  
		end
	end 
end