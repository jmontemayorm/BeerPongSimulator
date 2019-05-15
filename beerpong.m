%% Beerpong Simulator: Main

%% Settings
% Generations
enableMaxGenerations = 1;
maxGenerations = 5000;

% Timeout
enableTimeout = 1;
timeoutMinutes = 5;

% Console output
suppressOutput = 0;
modulateOutput = 1;
outputModulation = 100;

% Elitism
enableElitism = 1;
elitismFraction = 0.1;

% Population and mutation
populationSize = 2^7; % Must be a power of 2, because of the tournament

maxShotsPerPlayer = 20;

paternalProbability = 0.6;

mutationProbability = 0.000001;
maxMutationSize = 0.1;

% Cooldown
enableCooldown = 0;
cooldownModulation = 1000;
cooldownSeconds = 15;

%% Calculated settings
% Timeout
timeout = timeoutMinutes * 60;

% Elitism
if enableElitism == 0
    elitismFraction = 0;
end
eliteAmount = floor(populationSize * elitismFraction);
nonEliteIdx = (eliteAmount + 1):populationSize;

% Mutation
% eta = (finalMutationProbability - initialMutationProbability) / finalDynamicGeneration;  
% alpha = (finalMutationProbability / initialMutationProbability) ^ (1 / finalDynamicGeneration);

%% Initial population
players = cell(populationSize,1);

for p = 1:populationSize
    players{p} = createNeuralNetwork;
end

exampleNN = players{1};

%% Evolution
generation = 1;

bestOfGeneration = cell(maxGenerations,2);

tic
while true % Breaking conditions found before updating the counter
    
    fprintf('Starting tournament for generation %05i...\n',generation);
    
    % Run tournament
    ranking = playTournament(players,maxShotsPerPlayer);
    
    % % % Survival of the fittest % % %
    % Acquire targets
    killed = 0;
    killIdx = false(1,populationSize);
    while killed < populationSize / 2
        % Go from unfittest to fittest
        unfitToFit = flip(ranking(nonEliteIdx)); % Only the non elite
        
        for p = 1:(populationSize - eliteAmount)
            player = unfitToFit(p);
            % Always include probability of survival (also for unfittest, elitism exception)
            if (killIdx(player) == false) && (exp(find(player == ranking,1)/populationSize - 1.1) >= rand)
                % Acquire target
                killIdx(player) = true;
                
                % Increase counter and check
                killed = killed + 1;
                if killed >= populationSize / 2
                    break
                end
            end
        end
    end
    
    % Save the best 2
    bestOfGeneration{generation,1} = players{ranking(1)};
    bestOfGeneration{generation,2} = players{ranking(2)};
    
    % Make clones of the best 2
    cloneIdx = find(killIdx,2);
    players{cloneIdx(1)} = players{ranking(1)};
    players{cloneIdx(2)} = players{ranking(2)};
    killIdx(cloneIdx(:)) = false;
    
    % Kill and substitute via reproduction
    replaceWithBaby = find(killIdx);
    for newBaby = 1:length(replaceWithBaby)
        % Only search in the ones not to be killed
        allowedIdx = ~killIdx;
        
        % Get first parent
        firstParentIdx = 0;
        lookingForFirstParent = true;
        while lookingForFirstParent
            % The most fit are the firsts in line
            orderedCandidatesIdx = ranking(allowedIdx);
            
            for candidate = 1:length(orderedCandidatesIdx)                
                if rand < paternalProbability
                    lookingForFirstParent = false;
                    firstParentIdx = orderedCandidatesIdx(candidate);
                    allowedIdx(firstParentIdx) = false;
                    break
                end
            end
        end
        
        % Get second parent
        secondParentIdx = 0;
        lookingForSecondParent = true;
        while lookingForSecondParent
            % The most fit are the firsts in line
            orderedCandidatesIdx = ranking(allowedIdx);
            
            for candidate = 1:length(orderedCandidatesIdx)
                if rand < paternalProbability
                    lookingForSecondParent = false;
                    secondParentIdx = orderedCandidatesIdx(candidate);
                    break
                end
            end
        end
        
        % Make baby
        for layer = 1:length(exampleNN.layers)
            firstParent = randi([0, 1], size(exampleNN.layers{layer}));
            secondParent = ~firstParent;
            players{replaceWithBaby(newBaby)}.layers{layer} = firstParent .* players{firstParentIdx}.layers{layer} + secondParent .* players{secondParentIdx}.layers{layer};
        end
    end
    
    % % % Mutations % % %    
    % Mutate
    for player = 1:populationSize
        for layer = 1:length(exampleNN.layers)
            mutate = rand(size(exampleNN.layers{layer})) < mutationProbability;
            sign = 2 * randi([0,1],size(exampleNN.layers{layer})) - 1;
            mutation = maxMutationSize .* rand(size(exampleNN.layers{layer}));

            players{player}.layers{layer}(mutate) = players{player}.layers{layer}(mutate) + sign(mutate) .* mutation(mutate);
            players{player}.layers{layer}(players{player}.layers{layer} < -1) = -1;
            players{player}.layers{layer}(players{player}.layers{layer} > 1) = 1;
        end
    end
    
    % % % Breaking mechanisms % % %
    % Break when achieving max generation
    if (enableMaxGenerations == 1 && generation == maxGenerations)
        break
    end
    
    % Break when achieving timeout
    if (enableTimeout == 1 && toc >= timeout)
        break
    end
    
    % Cooldown
    if enableCooldown == 1 && mod(generation,cooldownModulation) == 0
        pause(cooldownSeconds)
    end
    
    % Go to the next generation
    generation = generation + 1;
end

elapsedTime = toc;
toc

fprintf('Evolution sequence complete. Achieved generation %05i!\n',generation);

