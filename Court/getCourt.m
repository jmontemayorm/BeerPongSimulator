function court = getCourt()
    % TODO: Add description
    
    % Initialize court as struct
    court = struct;
    
    % Get a figure for the court
    court.figure = figure;
    
    % Limits
    court = getCourtLimits(court);
    
    % Floor
    court = getCourtFloor(court);
    
    % Table
    court = getCourtTable(court);
    
    % Cups
    cupHeight = 0.12065; % [m]
    cupTopRadius = 0.047625; % [m]
    cupBottomRadius = 0.03175; % [m]
    cupColor = [211 44 39] ./ 255;
    cylinderVertices = 32;
    cupEdgeAlpha = 0.25;
    
    cupR = [cupBottomRadius cupTopRadius];
    [cupX,cupY,cupZ] = cylinder(cupR,cylinderVertices-1);
    cupZ = cupHeight * cupZ;
    
    cupVertices = zeros(size(cupX,1)*size(cupX,2),3);
    cupFaces = zeros(size(cupX,2),4);
    for vertex = 1:size(cupX,2)
        bottomIdx = 2 * vertex - 1;
        topIdx = 2 * vertex;
        
        cupVertices(bottomIdx,:) = [cupX(1,vertex) cupY(1,vertex) cupZ(1,vertex)];
        cupVertices(topIdx,:) = [cupX(2,vertex) cupY(2,vertex) cupZ(2,vertex)];
        
        vIdx = 2 * vertex - 1;
        cupFaces(vertex,:) = [vIdx vIdx+1 vIdx+3 vIdx+2];
    end
    cupFaces(cupFaces > size(cupVertices,1)) = cupFaces(cupFaces > size(cupVertices,1)) - size(cupVertices,1);
    cupBase = 1:2:size(cupVertices,1);
    
%     scatter3(cupX(:),cupY(:),cupZ(:))
%     hold on
%     axis equal
%     patch('Faces',cupFaces,'vertices',cupVertices,'FaceColor',cupColor,'EdgeAlpha',cupEdgeAlpha)
%     patch('Faces',cupBase,'vertices',cupVertices,'FaceColor',cupColor,'EdgeAlpha',cupEdgeAlpha)
    

    court.cups = struct;
    
    
        % TODO: Change axis stuff
%     axis equal
%     axis manual
%     axis(court.limits.axis)
%     grid on
end