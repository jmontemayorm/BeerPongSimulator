function neuralNetwork = createNeuralNetwork()
    % TODO: Add description (randomized neural network, 12, 18, 12, 18, 12,
    % 6 in, 6 out)
    
    neuralNetwork = struct;
    neuralNetwork.layers = cell(1,6);
    
    % 6 inputs -> 12 neurons
    neuralNetwork.layers{1} = 2 * rand(12,6) - 1;
    
    % 12 neurons -> 18 neurons
    neuralNetwork.layers{2} = 2 * rand(18,12) - 1;
    
    % 18 neurons -> 12 neurons
    neuralNetwork.layers{3} = 2 * rand(12,18) - 1;
    
    % 12 neurons -> 18 neurons
    neuralNetwork.layers{4} = 2 * rand(18,12) - 1;
    
    % 18 neurons -> 12 neurons
    neuralNetwork.layers{5} = 2 * rand(12,18) - 1;
    
    % 12 neurons -> 6 outputs
    neuralNetwork.layers{6} = 2 * rand(6,12) - 1;
    
    % Sigmoid function to normalize results
    neuralNetwork.sigmoidF = @(x) 1 ./ (1 + exp(-x));
end

