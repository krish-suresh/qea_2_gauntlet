function map = gauntletMap()
    image = imread('occupancymaprotgoalremoved.png');
    grayimage = rgb2gray(image);
    bwimage = grayimage < 0.5;
    
    mapData = ones(size(bwimage));
    wallThickness = 40;
    mapData(wallThickness+1:end-wallThickness,wallThickness+1:end-wallThickness) = bwimage(wallThickness+1:end-wallThickness,wallThickness+1:end-wallThickness);
    
    map = binaryOccupancyMap(mapData,'Resolution',100);
    map.GridLocationInWorld = [-1.5 -3.37];
end

