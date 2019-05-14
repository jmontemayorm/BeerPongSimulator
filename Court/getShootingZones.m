function court = getShootingZones(court)
    % TODO: Add description
    
    % Size
    court.shootingZones.xSize = 1; % [m]
    court.shootingZones.ySize = 1; % [m]
    court.shootingZones.zSize = 1; % [m]
    court.shootingZones.tableOverlap = 0.1; % [m]
    court.shootingZones.heightOverTable = 0.1; % [m]
    
    vertices = [ ...
        0 0 0; ...
        1 0 0; ...
        1 1 0; ...
        0 1 0; ...
        0 0 1; ...
        1 0 1; ...
        1 1 1; ...
        0 1 1];
    
    % Centering y
    vertices(:,2) = vertices(:,2) - 0.5;
    
    % Scaling
    vertices(:,1) = court.shootingZones.xSize * vertices(:,1);
    vertices(:,2) = court.shootingZones.ySize * vertices(:,2);
    vertices(:,3) = court.shootingZones.zSize * vertices(:,3);
    
    % Rising
    vertices(:,3) = vertices(:,3) + court.table.bottomHeight + court.table.thickness;
    vertices(:,3) = vertices(:,3) + court.shootingZones.heightOverTable;
    
    % Adjusting x
    vertices(:,1) = vertices(:,1) + court.table.length / 2;
    vertices(:,1) = vertices(:,1) - court.shootingZones.tableOverlap;
    
    court.shootingZones.player1.faces = [ ...
        1 2 3 4; ...
        1 2 6 5; ...
        2 3 7 6; ...
        3 4 8 7; ...
        4 1 5 8; ...
        5 6 7 8];
    court.shootingZones.player2.faces = court.shootingZones.player1.faces;
    
    court.shootingZones.player1.vertices = vertices;
    
    % Copy for player 2 and mirror in x
    court.shootingZones.player2.vertices = court.shootingZones.player1.vertices;
    court.shootingZones.player2.vertices(:,1) = -court.shootingZones.player2.vertices(:,1);
    
    % Add calculated data
    court.shootingZones.minX = min(abs(vertices(:,1)));
    court.shootingZones.maxX = max(abs(vertices(:,1)));
    court.shootingZones.minY = min(vertices(:,2));
    court.shootingZones.maxY = max(vertices(:,2));
    court.shootingZones.minZ = min(vertices(:,3));
    court.shootingZones.maxZ = max(vertices(:,3));
    
    % Add to the figure
    if court.isVisible
        figure(court.figure)
        hold on
        court.shootingZones.handlers.player1 = ...
            patch('Faces',court.shootingZones.player1.faces, ...
            'Vertices',court.shootingZones.player1.vertices, ...
            'FaceColor','none','EdgeColor','r');
        court.shootingZones.handlers.player2 = ...
            patch('Faces',court.shootingZones.player1.faces, ...
            'Vertices',court.shootingZones.player2.vertices, ...
            'FaceColor','none','EdgeColor','b');
    end
end