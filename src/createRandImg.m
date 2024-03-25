function img = createRandImg(imgResolution, minValue, maxValue)
    % Creates a matrix of random values between minValue and maxValue.
    % Args:
    %   imgResolution (2-element array): Specifies the size of the matrix (rows, columns).
    %   minValue (double): Minimum value for random numbers.
    %   maxValue (double): Maximum value for random numbers.
    % Returns:
    %   randomMatrix (double array): A matrix of random values.

    rows = imgResolution(1);
    cols = imgResolution(2);
    img = randi([minValue, maxValue], rows, cols);
end