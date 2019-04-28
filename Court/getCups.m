function court = getCups(court)
    % GETCUPS adds 6 cups to each side of the table and returns an updated
    % court struct.
    
    % Cup data
    court.cups.height = 0.12065; % [m]
    court.cups.floatingSpace = 1e-3; % [m]
    court.cups.topRadius = 0.047625; % [m]
    court.cups.bottomRadius = 0.03175; % [m]
    court.cups.spacing = 0.01; % [m]
    court.cups.backSpacing = 0.05; % [m]
    court.cups.color = [211 44 39] ./ 255;
    court.cups.cylinderVertices = 32;
    court.cups.edgeAlpha = 0.25;
    
    % Template cup data
    cupR = [court.cups.bottomRadius court.cups.topRadius];
    [cupX,cupY,cupZ] = cylinder(cupR,court.cups.cylinderVertices-1);
    cupZ = court.cups.height * cupZ;
    
    % Vertices and faces transformation
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
    
    % Save original data into the struct
    court.cups.vertices = cupVertices;
    court.cups.faces = cupFaces;
    court.cups.base = cupBase;
    
    % Preallocate memory
    court.cups.sprites.player1 = cell(1,6);
    court.cups.sprites.player2 = cell(1,6);
    
    % Cup arrangement: Spacing
    xSpacing = sin(pi/3) * (2 * court.cups.topRadius + court.cups.spacing);
    ySpacing = cos(pi/3) * (2 * court.cups.topRadius + court.cups.spacing);
    
    % Cup arrangement: Back Middle
    cupBackMiddle = court.cups.vertices;
    
    cupBackMiddle(:,3) = cupBackMiddle(:,3) + court.table.bottomHeight;
    cupBackMiddle(:,3) = cupBackMiddle(:,3) + court.table.thickness + court.cups.floatingSpace;
    
    cupBackMiddle(:,1) = cupBackMiddle(:,1) + court.table.length / 2;
    cupBackMiddle(:,1) = cupBackMiddle(:,1) - court.cups.topRadius;
    cupBackMiddle(:,1) = cupBackMiddle(:,1) - court.cups.backSpacing;
    
    court.cups.sprites.player1{1} = cupBackMiddle;
    
    % Cup arrangement: Back Right
    cupBackRight = cupBackMiddle;
    cupBackRight(:,2) = cupBackRight(:,2) + 2 * court.cups.topRadius;
    cupBackRight(:,2) = cupBackRight(:,2) + court.cups.spacing;
    
    court.cups.sprites.player1{2} = cupBackRight;
    
    % Cup arrangement: Back Left
    cupBackLeft = cupBackMiddle;
    cupBackLeft(:,2) = cupBackLeft(:,2) - 2 * court.cups.topRadius;
    cupBackLeft(:,2) = cupBackLeft(:,2) - court.cups.spacing;
    
    court.cups.sprites.player1{3} = cupBackLeft;
    
    % Cup arrangement: Middle Right
    cupMiddleRight = cupBackMiddle;
    cupMiddleRight(:,1) = cupMiddleRight(:,1) - xSpacing;
    cupMiddleRight(:,2) = cupMiddleRight(:,2) + ySpacing;
    
    court.cups.sprites.player1{4} = cupMiddleRight;
    
    % Cup arrangement: Middle Left
    cupMiddleLeft = cupBackMiddle;
    cupMiddleLeft(:,1) = cupMiddleLeft(:,1) - xSpacing;
    cupMiddleLeft(:,2) = cupMiddleLeft(:,2) - ySpacing;
    
    court.cups.sprites.player1{5} = cupMiddleLeft;
    
    % Cup arrangement: Front
    cupFront = cupBackMiddle;
    cupFront(:,1) = cupFront(:,1) - 2 * xSpacing;
    
    court.cups.sprites.player1{6} = cupFront;
    
    % Cup arrangement: Mirror for player 2
    for cup = 1:6
        court.cups.sprites.player2{cup} = court.cups.sprites.player1{cup};
        court.cups.sprites.player2{cup}(:,1) = -court.cups.sprites.player2{cup}(:,1);
    end
    
    % Preallocate memory for handlers
    court.cups.handlers.player1.cup = cell(1,6);
    court.cups.handlers.player1.base = cell(1,6);
    court.cups.handlers.player2.cup = cell(1,6);
    court.cups.handlers.player2.base = cell(1,6);
    
    % Add to the figure
    figure(court.figure)
    hold on
    for c = 1:6
        % Player 1
        court.cups.handlers.player1.cup{c} = ...
            patch('Faces',court.cups.faces, ...
            'vertices',court.cups.sprites.player1{c}, ...
            'FaceColor',court.cups.color, ...
            'EdgeAlpha',court.cups.edgeAlpha);
        court.cups.handlers.player1.base{c} = ...
            patch('Faces',court.cups.base, ...
            'vertices',court.cups.sprites.player1{c}, ...
            'FaceColor',court.cups.color, ...
            'EdgeAlpha',court.cups.edgeAlpha);
        
        % Player 2
        court.cups.handlers.player2.cup{c} = ...
            patch('Faces',court.cups.faces, ...
            'vertices',court.cups.sprites.player2{c}, ...
            'FaceColor','b', ...
            'EdgeAlpha',court.cups.edgeAlpha);
        court.cups.handlers.player2.base{c} = ...
            patch('Faces',court.cups.base, ...
            'vertices',court.cups.sprites.player2{c}, ...
            'FaceColor','b', ...
            'EdgeAlpha',court.cups.edgeAlpha);
    end
end

