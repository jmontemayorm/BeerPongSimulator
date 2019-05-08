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
    
    disp(outData)
end

