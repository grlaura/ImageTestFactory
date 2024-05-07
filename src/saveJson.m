function saveJson(data, filename)
    % Save a 2D array to a JSON file with the specified filename.
    % Input:
    %   - data: Struct
    %   - filename: Name of the output JSON file (e.g., 'output.json')
    

    % Convert the struct to a JSON-formatted string
    jsonStr = jsonencode(data);

    % Write the JSON string to the specified file


    fid = fopen(filename, 'w');
    fprintf(fid, '%s', jsonStr);
    fclose(fid);
end