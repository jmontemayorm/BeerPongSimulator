function court = getFloor(court)
    % TODO: Add description
    
    % Floor
    court.floor.vertices = [ ...
        court.limits.xMin court.limits.yMin court.limits.zMin; ...
        court.limits.xMax court.limits.yMin court.limits.zMin; ...
        court.limits.xMax court.limits.yMax court.limits.zMin; ...
        court.limits.xMin court.limits.yMax court.limits.zMin];
    court.floor.faces = [1 2 3 4];
    court.floor.color = [50 114 34] ./ 255;
    
    % Add to the figure
    if court.isVisible
        figure(court.figure)
        hold on
        court.floor.pHandler = patch('Faces',court.floor.faces,'Vertices',court.floor.vertices,'FaceColor',court.floor.color);
    end
end