% Neural network mutations test

% Mutation settings
mutationProbability = 0.1;
maxMutationSize = 0.3;

% Get dummy neural network
nn = createNeuralNetwork();
original = nn;

for layer = 1:length(nn.layers)
    mutate = rand(size(nn.layers{layer})) < mutationProbability;
    sign = 2 * randi([0,1],size(nn.layers{layer})) - 1;
    mutation = maxMutationSize .* rand(size(nn.layers{layer}));
    
    nn.layers{layer}(mutate) = nn.layers{layer}(mutate) + sign(mutate) .* mutation(mutate);
    nn.layers{layer}(nn.layers{layer} < -1) = -1;
    nn.layers{layer}(nn.layers{layer} > 1) = 1;
end