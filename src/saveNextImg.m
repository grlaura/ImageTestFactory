function saveNumStr = saveNextImg (img, saveDirectory, prefix, fileType)

    maxNumInDir = getMaxSeqNumber(saveDirectory, prefix);
    saveNum = maxNumInDir+1;
    saveNumStr = num2str(saveNum,'%03.f');
    fileName = [prefix, num2str(saveNum,'%03.f')];
    filePath = [saveDirectory, fileName, fileType];

    disp (filePath);

    
    imwrite(img, filePath);



end