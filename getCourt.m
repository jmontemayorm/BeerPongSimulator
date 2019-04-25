function court = getCourt()
    % TODO: Add description
    
    % Initialize court as struct
    court = struct;
    
    % Get a figure for the court
    court.figure = figure;
    
    % Set the axis limits
    court.limits = struct;
    
    court.limits.xMin = -5; % [m]
    court.limits.xMax = 5; % [m]
    
    court.limits.yMin = -3; % [m]
    court.limits.yMax = 3; % [m]
    
    court.limits.zMin = 0; % [m]
    court.limits.zMax = 3; % [m]
    
    court.limits.axis = [ ...
        court.limits.xMin ...
        court.limits.xMax ...
        court.limits.yMin ...
        court.limits.yMax ...
        court.limits.zMin ...
        court.limits.zMax];
    
    % Floor
    court.floor.vertices = [ ...
        court.limits.xMin court.limits.yMin court.limits.zMin; ...
        court.limits.xMax court.limits.yMin court.limits.zMin; ...
        court.limits.xMax court.limits.yMax court.limits.zMin; ...
        court.limits.xMin court.limits.yMax court.limits.zMin];
    court.floor.faces = [1 2 3 4];
    court.floor.color = [50 114 34] ./ 255;
    
    court.floor.pHandler = patch('Faces',court.floor.faces,'Vertices',court.floor.vertices,'FaceColor',court.floor.color);
    axis equal
    axis manual
    axis(court.limits.axis)
    grid on
    
    % Table
    court.table = struct;
    
    % Table: Size
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
    
    % Table: Centering
    court.table.vertices(:,1) = court.table.vertices(:,1) - 0.5;
    court.table.vertices(:,2) = court.table.vertices(:,2) - 0.5;
    
    % Table: Scaling
    court.table.vertices(:,1) = court.table.length * court.table.vertices(:,1);
    court.table.vertices(:,2) = court.table.width * court.table.vertices(:,2);
    court.table.vertices(:,3) = court.table.thickness * court.table.vertices(:,3);
    
    % Table: Rising
    court.table.vertices(:,3) = court.table.vertices(:,3) + court.table.bottomHeight;
    
    court.table.faces = [ ...
        1 2 3 4; ...
        1 2 6 5; ...
        2 3 7 6; ...
        3 4 8 7; ...
        4 1 5 8; ...
        5 6 7 8];
    
    court.table.color = [0.9 0.9 0.9];
    
    court.table.pHandler = patch('Faces',court.table.faces,'Vertices',court.table.vertices,'FaceColor',court.table.color);
    axis equal
    axis manual
    axis(court.limits.axis)
    grid on
    
    % Cups
    cupHeight = 0.12065; % [m]
    cupTopRadius = 0.047625; % [m]
    cupBottomRadius = 0.03175; % [m]
    cupColor = [211 44 39] ./ 255;

    court.cups = struct;
end