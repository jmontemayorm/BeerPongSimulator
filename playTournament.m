function Ranking = playTournament(Players)

populationSize = length(Players);

%Initial values of tournament
Shots = 10;
n = 4;
populationSize = 2^n;
NMatches = populationSize/2;


% % %Create players
% % Players = cell(populationSize,1);
% % for NewPlayer = 1:populationSize
% %     Players{NewPlayer} = createNeuralNetwork();
% % end


% Tournament preparations
Advances = cell(n+1,1);
for Ad = 1:n+1
    Advances{Ad} = zeros(2^(n+1-Ad),1);
end
Advances{1} = 1:populationSize;

Ranking = zeros(populationSize,1);
count = 1;



%Face off
for Rounds = 1:n
    
    Round = reshape(randperm(NMatches*2)',2,NMatches,[])';
    
    for Matches = 1:NMatches
        
        Red1 = Players{Advances{n}(Round(n,1))};
        Blue2 = Players{Advances{n}(Round(n,2))};
        [Redscore1,Bluescore2] = beerpongMatch(Red1,Blue2,Shots,false);
    
        if Redscore1 >= Bluescore2
            Advances{n+1}(NMatches) = (Advances{n}(Round(n,1)); %Red1 Advances
            Ranking(count) = (Advances{n}(Round(n,2)); %Blue2 Losses
        else
           Advances{n+1}(NMatches) = (Advances{n}(Round(n,2)); %Blue2 Advances
           Ranking(count) = (Advances{n}(Round(n,2)); %Red1 Losses
        end
        
        count = count + 1;
    end
    NMatches = NMatches/2; 
end


%Order Raking in right order
Ranking = flip(Ranking);

end