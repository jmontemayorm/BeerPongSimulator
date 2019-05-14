%% Beerpong Simulator: Main

%% Settings
% Generations
enableMaxGenerations = 1;
maxGenerations = 5000;

% Timeout
enableTimeout = 1;
timeoutMinutes = 1;

% Console output
suppressOutput = 0;
modulateOutput = 1;
outputModulation = 100;

% Elitism
enableElitism = 1;
elitismFraction = 0.1;

% Population
populationSize = 2^7; % Must be a power of 2, because of the tournament

paternalProbability = 0.6;

% Mutation (0 = static, 1 = linear, 2 = exponential, 3 = cyclical)
dynamicMutation = 3;

staticMutationProbability = 0.000001;

initialMutationProbability = 0.00005;
finalMutationProbability = 0.0000005;

finalDynamicGeneration = 30000;

cyclicalWavelengthInGenerations = 150;

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
eta = (finalMutationProbability - initialMutationProbability) / finalDynamicGeneration;  
alpha = (finalMutationProbability / initialMutationProbability) ^ (1 / finalDynamicGeneration);

%% Initial population
players = cell(populationSize,1);

for p = 1:populationSize
    players{p} = createNeuralNetwork;
end

%% Evolution
generation = 1;

tic
while true % Breaking conditions found before updating the counter
    
    %fitness = tournament(); 
    
    % % % Survival of the fittest % % %
    % Acquire targets
    killed = 0;
    killIdx = false(1,populationSize);
    while killed < populationSize / 2
        % Go from unfittest to fittest
        unfitToFit = flip(bestIdx(nonEliteIdx)); % Only the non elite
        
        for p = 1:(populationSize - eliteAmount)
            player = unfitToFit(p);
            % Always include probability of survival (also for unfittest, elitism exception)
            if (killIdx(player) == false) && (exp(find(player == bestIdx,1)/populationSize - 1.1) >= rand)
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
    
%     % TODO: CHANGE BEST SPECIMEN
%     % Make 2 clones of the best
%     cloneIdx = find(killIdx,2);
%     players{cloneIdx(1)} = bestSpecimen;
%     players{cloneIdx(2)} = bestSpecimen;
%     killIdx(cloneIdx(:)) = false;
    
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
            orderedCandidatesIdx = bestIdx(allowedIdx);
            
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
            orderedCandidatesIdx = bestIdx(allowedIdx);
            
            for candidate = 1:length(orderedCandidatesIdx)
                if rand < paternalProbability
                    lookingForSecondParent = false;
                    secondParentIdx = orderedCandidatesIdx(candidate);
                    break
                end
            end
        end
        
        % TODO: ADAPT
        % Make baby
        for layer = 1:length()
        end
        firstParent = randi([0, 1], [numOfPolygons, 1]);
        secondParent = ~firstParent;
        players{replaceWithBaby(newBaby)} = firstParent .* players{firstParentIdx} + secondParent .* players{secondParentIdx};
        
        
        % EXAMPLE
        for layer = 1:length(nn.layers)
            mutate = rand(size(nn.layers{layer})) < mutationProbability;
            sign = 2 * randi([0,1],size(nn.layers{layer})) - 1;
            mutation = maxMutationSize .* rand(size(nn.layers{layer}));

            nn.layers{layer}(mutate) = nn.layers{layer}(mutate) + sign(mutate) .* mutation(mutate);
            nn.layers{layer}(nn.layers{layer} < -1) = -1;
            nn.layers{layer}(nn.layers{layer} > 1) = 1;
        end
    end
    
    % % % Mutations % % %
    % Stick to a static mutation if dynamic has ended
    if generation > finalDynamicGeneration
        dynamicMutation = 0;
    end

    % Calculate the respective mutation probability
    if dynamicMutation == 1
        mutationProbability = initialMutationProbability - eta * generation;
    elseif dynamicMutation == 2
        mutationProbability = initialMutationProbability * alpha ^ generation;
    elseif dynamicMutation == 3
        normalizedCosine = 0.5 * (1 + cos(2 * pi * generation / cyclicalWavelengthInGenerations));
        mutationProbability = finalMutationProbability + (initialMutationProbability - finalMutationProbability) * normalizedCosine;
    else
        mutationProbability = staticMutationProbability;
    end
    
    % Mutate
    for player = 1:populationSize
        mutate = rand(numOfPolygons, geneSize) < mutationProbability;
        players{player}(mutate) = ~players{player}(mutate);
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
