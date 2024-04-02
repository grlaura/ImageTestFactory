% Input Parameters

% The range of positions should be a bit wider than what we are
% actually planning to have
% Bounds: Format is [XangMin, XangMax, YangMin, YangMax, ZangMin, ZangMax]

filename = 'config.json';
loadedData = loadParseJson(filename);

angBounds = loadedData.angBounds_K;
tBounds = loadedData.tBounds_K;
params.maxArea = loadedData.maxArea_K;

loadedDataPts = loadParseJson(loadedData.worldPtsFile_K);
worldPts = loadedDataPts.pointCoordinates;

prefix = 'image_';
saveDirectory = '../results/PosExamples/';
fileType = '.png';

addpath('..\..\shared');

% Setting Camera Paramaters
imageSize = [480,640];
principalPoint = imageSize(1:2)./2 + 0.5;
focalL=6; %in mm
sensorW=10;
f = focalL/(sensorW/imageSize(2)); % in pxls
focalLength = [f,f];
intrinsicParams = cameraIntrinsics(focalLength,principalPoint,imageSize);

radius = 5; 
worldPointsFull = [];
gridSize = 20;
for PtN=1:size(worldPts,1)
    x1 = worldPts(PtN, 1);  % x-coordinate of the center
    y1 = worldPts(PtN, 2);  % y-coordinate of the center
    gridPoints = generateCircleGrid(x1, y1, radius, gridSize);
    worldPointsFull = [worldPointsFull; gridPoints];
end
worldPointsFull(:,3 ) = 0;

% Calculatin centre of Constlation, making selection of transforms more intuitive
centre(1) = mean([max(worldPts(:,1)), min(worldPts(:,1))]);
centre(2) = mean([max(worldPts(:,2)), min(worldPts(:,2))]);
centre(3) = mean([max(worldPts(:,3)), min(worldPts(:,3))]);
RT44c = RTtoTransform(eye(3,3), centre);

%% Create a set of random positions - check if points are in image
rng(2);
numPsts =10; %number of poses to generate 
margin = 30; % margin to edge of image

numPts = size(worldPointsFull,1);

saveRotationMatrices = zeros(numPsts, 3,3);
saveTranslationVectors = zeros(numPsts, 3);
saveImgPts = zeros(numPsts, numPts, 2);
saveIdxs = zeros(numPsts, numPts);

currentnumPsts = 0;

while currentnumPsts < numPsts % keep creating poses until target number is reached

    xtransl = tBounds(1) + (tBounds(2) - tBounds(1)) * rand();
    ytransl = tBounds(3) + (tBounds(4) - tBounds(3)) * rand();
    ztransl = tBounds(5) + (tBounds(6) - tBounds(5)) * rand();
    
    xang = angBounds(1) + (angBounds(2) - angBounds(1)) * rand();
    yang = angBounds(3) + (angBounds(4) - angBounds(3)) * rand();
    zang = angBounds(5) + (angBounds(6) - angBounds(5)) * rand();
    
    rotationMatrix = rotz(xang)*roty(yang)*rotx(zang);
    translationVector = [xtransl,ytransl,ztransl];
    
    RT34c = RTtoTransform(rotationMatrix, translationVector);
    RT34 = inv(RT44c)*RT34c;
    rotationMatrix = RT34(1:3, 1:3);
    translationVector = RT34(4, 1:3);
    
    % Projecting Points
    projectedPts= worldToImage(intrinsicParams,rotationMatrix,translationVector,worldPointsFull);
    
    % Add noise to image points
    %noisyImagePts = projectedPts + noiseLevel * 2* (rand(size(projectedPts))-0.5);
    %noisyImagePts = projectedPts;
    
    %Normalize Points
    %K = intrinsicParams.IntrinsicMatrix;
    %normImagePts = [noisyImagePts ones(size(noisyImagePts, 1), 1)] *inv(K); % normalize
    
    imagePtsOrdered = projectedPts(:,1:2);
    %imagePtsOrdered = projectedPts;

    % Check if projected points are in the image
    if (sum(projectedPts(:,1)<imageSize(2)-margin) ~= numPts || sum(projectedPts(:,2)<imageSize(1)-margin) ~= numPts || sum(projectedPts(:,2)>margin) ~= numPts || sum(projectedPts(:,1)>margin) ~= numPts)
        disp('Skipping pose - out of FOV');
        continue;
    end
   
    currentnumPsts = currentnumPsts +1;
    saveImgPts(currentnumPsts,:,:) = imagePtsOrdered;
    
    saveRotationMatrices(currentnumPsts,:,:) = rotationMatrix;
    saveTranslationVectors(currentnumPsts,:) = translationVector;
    
    RT34rand{currentnumPsts} = RT34;
end

% Generate Images and Save
for i=1:size (saveImgPts,1)
    imgPts = round(squeeze(saveImgPts(i, :, :)));
    img = create_image_from_points(imgPts, imageSize);
    saveNextImg (img, saveDirectory, prefix, fileType)

end

