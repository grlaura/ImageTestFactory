function saveNextImg (img, saveDirectory, prefix, fileType)

    maxNumInDir = getMaxSeqNumber(saveDirectory, prefix);
    saveNum = maxNumInDir+1;
    fileName = [prefix, num2str(saveNum,'%03.f')];
    filePath = [saveDirectory, fileName, fileType];
    imwrite(img, filePath);

end