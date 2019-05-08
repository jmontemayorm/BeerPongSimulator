function court = shootBall(neuralNetwork,environment,court,player)
    % TODO: Add description
    
    % Get shooting angles and speed
    if player == 1
        inData = court.cups.status.player2;
    else
        inData = court.cups.status.player1;
    end
end

