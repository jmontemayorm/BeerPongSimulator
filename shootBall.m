function court = shootBall(neuralNetwork,environment,court,player)
    % TODO: Add description
    
    % Get shooting angles and speed
    if player == 1
        outData = court.cups.status.player2;
    else
        outData = court.cups.status.player1;
    end
    
   	for layer = 1:length(neuralNetwork.layers)
        outData = neuralNetwork.layers{layer} * outData;
        outData = neuralNetwork.sigmoidF(outData);
    end
    
    % Add random variations
    variations = 0.15 .* rand(6,1);
    signs = 2 .* randi([0,1],[6,1]) - 1;
    outData = signs .* variations + outData;
    outData(outData > 1) = 1;
    outData(outData < 0) = 0;
    
    % Create ball
    ball = createBall(outData);
    
    % Get XY plane height (cup entrance)
    xy_plane = court.table.bottomHeight + court.table.thickness + court.cups.floatingSpace + court.cups.height;
    
    % Loop while the ball is going upward or above the plane
    while (ball.posZ > xy_plane || ball.velZ >= 0)
        oldBall = ball;
        ball = propagateBall(ball,environment);
    end
    
    % Extrapolate to the XY plane
    delta_t = (xy_plane - oldBall.posZ) ./ oldBall.velZ;
    ballXY(1) = oldBall.posX + oldBall.velX * delta_t;
    ballXY(2) = oldBall.posY + oldBall.velY * delta_t;
end

