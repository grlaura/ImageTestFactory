function ellipseImage = createBlobsImg(imageSize, numEllipses, minEllipseSize, maxEllipseSize)
    % Generates an image with random ellipses.
    % Args:
    %   imageSize (2-element array): Specifies the size of the image (rows, columns).
    %   numEllipses (integer): Number of ellipses to generate.
    %   minEllipseSize (2-element array): Minimum ellipse size (major and minor axes).
    %   maxEllipseSize (2-element array): Maximum ellipse size (major and minor axes).
    % Returns:
    %   ellipseImage (double array): Image with random ellipses.

    % Initialize an empty image
    ellipseImage = zeros(imageSize);

    % Generate random ellipse parameters
    for i = 1:numEllipses
        centerRow = randi(imageSize(1));
        centerCol = randi(imageSize(2));
        majorAxis = randi([minEllipseSize, maxEllipseSize]);
        minorAxis = randi([minEllipseSize, maxEllipseSize]);
        angle = rand * 2 * pi;  % Random rotation angle

        % Create an ellipse
        [X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));
        ellipse = ((X - centerCol) / majorAxis).^2 + ((Y - centerRow) / minorAxis).^2 <= 1;
        
        % Rotate the ellipse
        rotatedEllipse = imrotate(ellipse, rad2deg(angle), 'bilinear', 'crop');
        % Add the rotated ellipse to the image
        ellipseImage = ellipseImage + rotatedEllipse;
    end

    % Normalize the image to [0, 255]
    ellipseImage = 255* (ellipseImage / max(ellipseImage(:)));
end