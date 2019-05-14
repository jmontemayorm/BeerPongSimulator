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
    ball = createBall(outData,court,player);
    
    % Get XY plane height (cup entrance)
    xy_plane = court.table.bottomHeight + court.table.thickness + court.cups.floatingSpace + court.cups.height;
    
    % Loop while the ball is going upward or above the plane
    while (ball.posZ > xy_plane || ball.velZ >= 0)
        oldBall = ball;
        ball = propagateBall(ball,environment);
        ball = drawBall(ball);
        pause(environment.dt)
    end
    
    % Extrapolate to the XY plane
    delta_t = (xy_plane - oldBall.posZ) ./ oldBall.velZ;
    
    ballXY(1) = oldBall.posX + oldBall.velX * delta_t;
    ballXY(2) = oldBall.posY + oldBall.velY * delta_t;
    
    % Detect hit, update score and remove cup
    cupIdx = 0;
    %cupIdx = detectHit(ballXY,court,player);
    if cupIdx ~= 0
        if player == 1 && court.cups.status.player2(cupIdx) == 1
            court.score.player1 = court.score.player1 + 1;
            
            court.cups.status.player2(cupIdx) = 0;
            delete(court.cups.handlers.player2.cup{cupIdx})
            delete(court.cups.handlers.player2.base{cupIdx})
        elseif player == 2 && court.cups.status.player1(cupIdx) == 1
            court.score.player2 = court.score.player2 + 1;
            
            court.cups.status.player1(cupIdx) = 0;
            delete(court.cups.handlers.player1.cup{cupIdx})
            delete(court.cups.handlers.player1.base{cupIdx})
        end
    end
    
    % Delete ball handler
    delete(ball.handler)
end

