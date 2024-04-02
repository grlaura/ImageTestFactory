function gridPoints = generateCircleGrid(x1, y1, radius, gridSize)
    % Generate points on a regular grid covering the circle area

    % Define the bounding box around the circle
    minX = x1 - radius;
    maxX = x1 + radius;
    minY = y1 - radius;
    maxY = y1 + radius;

    % Create a grid of points within the bounding box
    [X, Y] = meshgrid(linspace(minX, maxX, gridSize), linspace(minY, maxY, gridSize));
    
    % Check if each point is inside the circle
    insideCircle = (X - x1).^2 + (Y - y1).^2 <= radius^2;
    
    % Filter out points outside the circle
    gridPoints = [X(insideCircle) Y(insideCircle)];
end
