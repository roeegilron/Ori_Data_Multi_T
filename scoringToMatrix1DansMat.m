function data3d = scoringToMatrix1DansMat(mask, data, locations)
% this function takes 2D data and returns 3D data 
data3d = zeros(size(mask));
for i = 1:size(data,1)
    data3d(locations(i,1),locations(i,2),locations(i,3)) = data(i,1);
end
end