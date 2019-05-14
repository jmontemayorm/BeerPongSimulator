function court = getTable(court)
    % TODO: Add description
    
    % Size
    court.table.length = 1.82; % [m]
    court.table.width = 0.762; % [m]
    court.table.thickness = 0.042; % [m]
    court.table.bottomHeight = 0.762; % [m]
    
    court.table.vertices = [ ...
        0 0 0; ...
        1 0 0; ...
        1 1 0; ...
        0 1 0; ...
        0 0 1; ...
        1 0 1; ...
        1 1 1; ...
        0 1 1];
    
    % Centering
    court.table.vertices(:,1) = court.table.vertices(:,1) - 0.5;
    court.table.vertices(:,2) = court.table.vertices(:,2) - 0.5;
    
    % Scaling
    court.table.vertices(:,1) = court.table.length * court.table.vertices(:,1);
    court.table.vertices(:,2) = court.table.width * court.table.vertices(:,2);
    court.table.vertices(:,3) = court.table.thickness * court.table.vertices(:,3);
    
    % Rising
    court.table.vertices(:,3) = court.table.vertices(:,3) + court.table.bottomHeight;
    
    court.table.faces = [ ...
        1 2 3 4; ...
        1 2 6 5; ...
        2 3 7 6; ...
        3 4 8 7; ...
        4 1 5 8; ...
        5 6 7 8];
    
    court.table.color = [0.9 0.9 0.9];
    
    % Add to the figure
    if court.isVisible
        figure(court.figure)
        hold on
        court.table.pHandler = patch('Faces',court.table.faces,'Vertices',court.table.vertices,'FaceColor',court.table.color);
    end
end