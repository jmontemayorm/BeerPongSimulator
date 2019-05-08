function neuralNetwork = createNeuralNetwork()
    % TODO: Add description (randomized neural network, 5 hidden 12, 18,
    % 12, 18, 12, 6 in, 6 out)
    % activation functions???
    
    neuralNetwork = struct;
    neuralNetwork.hiddenLayers = cell(1,5);
    
    neuralNetwork.hiddenLayers{1} = 0;
    
    sigmoidF = @(x) 1 ./ (1 + exp(-x));
end

