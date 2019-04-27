function court = getCourt()
    % TODO: Add description
    
    % Initialize court as struct
    court = struct;
    
    % Get a figure for the court
    court.figure = figure;
    
    % Limits
    court = getCourtLimits(court);
    
    % Floor
    court = getCourtFloor(court);
    
    % Table
    court = getCourtTable(court);
    
    % Cups
    court = getCourtCups(court);
    
    
    % TODO: Change axis stuff
    axis equal
    axis manual
    axis(court.limits.axis)
    grid on
    view(30,30)
end