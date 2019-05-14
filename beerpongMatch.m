function [score1,score2] = beerpongMatch(neuralNetwork1,neuralNetwork2,maxShotsPerPlayer,isVisible)
    % TODO: Add description
    
    if nargin < 2
        error('Not enough input arguments.')
    end
    
    % Default max number of shootings per player
    if nargin == 2
        maxShotsPerPlayer = 100;
    end
    
    % Default visibility
    if nargin < 4
        isVisible = true;
    end
    
    % Get the court and envrionment
    court = getCourt(isVisible);
    environment = getEnvironment();
    
    % Neural Networks
    neuralNetworks{1} = neuralNetwork1;
    neuralNetworks{2} = neuralNetwork2;
    
    % Each player get one shot
    maxShots = 2 * maxShotsPerPlayer;
    currentShot = 0;
    
    while currentShot < maxShots
        % Get player number
        player = mod(currentShot,2) + 1;
        
        % Take shot
        court = shootBall(neuralNetworks{player},environment,court,player);
        if player == 1 && court.score.player1 == 6
            break
        elseif player == 2 && court.score.player2 == 6
            break
        end
        
        % Update shot count
        currentShot = currentShot + 1;
    end
    
    score1 = court.score.player1;
    score2 = court.score.player2;
end

