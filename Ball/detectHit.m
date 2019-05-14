function cupIdx = detectHit(ball,court,player)
    % TODO: Add description
    
    % Initialize cupIdx
    cupIdx = 0;
    
    % Extract opposite player's cups
    if player == 1
        cupCenters = court.cups.centers.player2;
    else
        cupCenters = court.cups.centers.player1;
    end
    
    % Extract ball center
    ballXY = [ball.posX ball.posY];
    
    % Detect hits
    radialDistances = sqrt(sum((repmat(ballXY,6,1) - cupCenters).^2,2));
    hits = radialDistances <= (court.cups.topRadius - ball.radius);
    
    % Detect cupIdx
    if any(hits)
        cupIdx = find(hits);
    end
end

