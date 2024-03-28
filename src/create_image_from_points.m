function output_image = create_image_from_points(imgPts, image_size)
    % Creates an image where the specified points are white and all other pixels are black.
    %
    % Args:
    %   imgPts (Nx2 array): List of 2D point coordinates (x, y).
    %   image_size (optional): Size of the output image. Defaults to [512, 512].
    %
    % Returns:
    %   output_image (logical array): Binary image with white points at imgPts.

    % Create an empty black image
    output_image = false(image_size);

    % Set the specified points to white
    for i = 1:size(imgPts, 1)
        x = imgPts(i, 1);
        y = imgPts(i, 2);
        if x >= 1 && x <= image_size(2) && y >= 1 && y <= image_size(1)
            output_image(y, x) = true;
        end
    end
end