function court = getCourt(isVisible)
    % GETCOURT builds and returns a court struct with relevant data and
    % figure handlers.
    
    % Initialize court as struct
    court = struct;
    
    if nargin == 1
        court.isVisible = isVisible;
    else
        court.isVisible = true;
    end
    
    % Get a figure for the court
    if court.isVisible
        court.figure = figure;
        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.12, 0.75, 0.8])
        pause(0.1)
    end
    
    % Limits
    court = getLimits(court);
    
    % Floor
    court = getFloor(court);
    
    % Table
    court = getTable(court);
    
    % Cups
    court = getCups(court);
    
    % Shooting zones
    court = getShootingZones(court);
    
    % Score
    court.score.player1 = 0;
    court.score.player2 = 0;
    
    % Figure setup
    if court.isVisible
        axis equal
        axis manual
        axis(court.limits.axis)
        grid on
        view(30,30)
    end

end