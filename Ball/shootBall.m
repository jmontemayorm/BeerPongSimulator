function court = shootBall(neuralNetwork,environment,court,player)
    % TODO: Add description
    
    % Get shooting angles and speed
    if player == 1
        %outData = court.cups.status.player2;
        idx = find(court.cups.status.player2,1);
        idx2 = randi([1,length(idx)],[1,1]);
        outData = court.cups.centers.player1(idx(idx2),:)';
    else
        %outData = court.cups.status.player1;
        idx = find(court.cups.status.player1,1);
        idx2 = randi([1,length(idx)],[1,1]);
        outData = court.cups.centers.player1(idx(idx2),:)';
    end
    
   	for layer = 1:length(neuralNetwork.layers)
        outData = neuralNetwork.layers{layer} * outData;
        outData = neuralNetwork.sigmoidF(outData);
    end
    
    % Add random variations
    variations = 0.075 .* rand(6,1);
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
        if court.isVisible
            ball = drawBall(ball);
            pause(0)
        end
    end
    
    % Extrapolate to the XY plane
    delta_t = (xy_plane - oldBall.posZ) ./ oldBall.velZ;
    newEnvironment = environment;
    environment.dt = delta_t;
    
    ball = propagateBall(oldBall,newEnvironment);
    
    % Detect hit, update score and remove cup
    cupIdx = detectHit(ball,court,player);
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
    if court.isVisible
        delete(ball.handler)
    end
end

