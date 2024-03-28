function myArray = loadJsonToArray(filename)
    % Loads a 2D array from a JSON file and converts it to a Matlab 2D array.
    %
    % Args:
    %   filename (string): Path to the JSON file.
    %
    % Returns:
    %   myArray (NxM array): Loaded 2D array.

    % Read the JSON file
    json_data = fileread(filename);

    % Parse the JSON data
    parsed_data = jsondecode(json_data);

    % Convert the loaded data to a Matlab 2D array
    myArray = parsed_data.data;
end