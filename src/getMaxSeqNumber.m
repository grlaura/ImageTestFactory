function maxNum = getMaxSeqNumber(dirPath, prefix)
    % Get a list of all files in the folder
    files = dir(fullfile(dirPath, [prefix, '*.png']));
    
    % Initialize the maximum number
    maxNum = 0;

    % Loop over all files
    for i = 1:length(files)
        % Get the current filename
        filename = files(i).name;
        
        % Extract the number from the filename
        num = str2double(regexp(filename, '\d*', 'match'));
        
        % Update the maximum number if necessary
        if num > maxNum
            maxNum = num;
        end
    end
end