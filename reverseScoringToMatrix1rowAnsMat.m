function ansMat = reverseScoringToMatrix1rowAnsMat(data3d, locations)
%% this function take as input 3D data and return 2D data 
linearInd = sub2ind(size(data3d), locations(:,1),  locations(:,2),  locations(:,3));
ansMat(:,1) = data3d(linearInd); 


end