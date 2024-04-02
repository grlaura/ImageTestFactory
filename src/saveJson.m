function save2DArrayToJson(array, filename)
    % Save a 2D array to a JSON file with the specified filename.
    % Input:
    %   - array: A 2D array (e.g., GTPointCoordinates)
    %   - filename: Name of the output JSON file (e.g., 'output.json')

    % Create a struct with the desired field name
    data.GTPointCoordinates = array;

    % Convert the struct to a JSON-formatted string
    jsonStr = jsonencode(data);

    % Write the JSON string to the specified file
    fid = fopen(filename, 'w');
    fprintf(fid, '%s', jsonStr);
    fclose(fid);
end