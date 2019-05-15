function neuralNetwork = createNeuralNetwork()
    % TODO: Add description (randomized neural network, 12, 18, 12, 18, 12,
    % 6 in, 6 out)
    
    networkSize = [2 12 18 12 18 12 6];
    
    % Initialize as struct and allocate memory
    neuralNetwork = struct;
    neuralNetwork.layers = cell(1,length(networkSize)-1);
    
    for layer = 1:length(neuralNetwork.layers)
        neuralNetwork.layers{layer} = 2 * rand(networkSize(layer + 1),networkSize(layer)) - 1;
    end
    
    % Sigmoid function to normalize results
    neuralNetwork.sigmoidF = @(x) 1 ./ (1 + exp(-x));
end

