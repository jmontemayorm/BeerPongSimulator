function court = getCourt()
    % TODO: Add description
    
    % Initialize court as struct
    court = struct;
    
    % Get a figure for the court
    court.figure = figure;
    
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
    
    % Figure setup
    axis equal
    axis manual
    axis(court.limits.axis)
    grid on
    view(30,30)
end