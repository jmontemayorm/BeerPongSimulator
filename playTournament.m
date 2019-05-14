function ranking = playTournament(players,maxShotsPerPlayer)
    % TODO: Add description
    
    % Extract population size
    populationSize = length(players);

    % Default maximum number of shots per player
    if nargin < 2
        maxShotsPerPlayer = 50;
    end
    
    numOfRounds = log2(populationSize);

    % Allocate tournament round places
    previousRoundVictories = cell(numOfRounds+1,1);
    for prv = 1:(numOfRounds + 1)
        previousRoundVictories{prv} = zeros(2^(numOfRounds + 1 - prv),1);
    end
    
    % All players go into the first round
    previousRoundVictories{1} = 1:populationSize;

    % Allocate for ranking
    ranking = zeros(populationSize,1);
    count = 1;

    numOfMatches = populationSize/2;
    
    % Play tournament
    for round = 1:numOfRounds
        matchOrder = reshape(randperm(numOfMatches*2)',2,numOfMatches,[])';

        for match = 1:numOfMatches
            home = players{previousRoundVictories{round}(matchOrder(match,1))};
            visitor = players{previousRoundVictories{round}(matchOrder(match,2))};
            [homeScore,visitorScore] = beerpongMatch(home,visitor,maxShotsPerPlayer,false);

            if homeScore >= visitorScore
                previousRoundVictories{round+1}(match) = previousRoundVictories{round}(matchOrder(match,1));
                ranking(count) = previousRoundVictories{round}(matchOrder(match,2));
            else
               previousRoundVictories{round+1}(match) = previousRoundVictories{round}(matchOrder(match,2));
               ranking(count) = previousRoundVictories{round}(matchOrder(match,1));
            end

            count = count + 1;
        end
        
        numOfMatches = numOfMatches/2; 
    end
    
    % Add winner to the ranking
    ranking(count) = previousRoundVictories{numOfRounds + 1};

    % Order Raking in right order
    ranking = flip(ranking);
end