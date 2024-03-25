function blobImage = createBlobImg(imageSize, numBlobs, minBlobSize, maxBlobSize)
    % Generates an image with random blobs.
    % Args:
    %   imageSize (2-element array): Specifies the size of the image (rows, columns).
    %   numBlobs (integer): Number of blobs to generate.
    %   minBlobSize (integer): Minimum blob size (radius or diameter).
    %   maxBlobSize (integer): Maximum blob size (radius or diameter).
    % Returns:
    %   blobImage (double array): Image with random blobs.

    % Initialize an empty image
    blobImage = zeros(imageSize);

    % Generate random blob centers and sizes
    for i = 1:numBlobs
        centerRow = randi(imageSize(1));
        centerCol = randi(imageSize(2));
        blobRadius = randi([minBlobSize, maxBlobSize]);
        
        % Create a circular blob
        [X, Y] = meshgrid(1:imageSize(2), 1:imageSize(1));
        blob = (X - centerCol).^2 + (Y - centerRow).^2 <= blobRadius^2;
        
        % Add the blob to the image
        blobImage = blobImage + blob;
    end

    % Normalize the image to [0, 1]
    blobImage = blobImage / max(blobImage(:));
end