function court = getCourtLimits(court)
    % TODO: Add description
    
    % Set the axis limits
    court.limits = struct;
    
    court.limits.xMin = -5; % [m]
    court.limits.xMax = 5; % [m]
    
    court.limits.yMin = -3; % [m]
    court.limits.yMax = 3; % [m]
    
    court.limits.zMin = 0; % [m]
    court.limits.zMax = 3; % [m]
    
    court.limits.axis = [ ...
        court.limits.xMin ...
        court.limits.xMax ...
        court.limits.yMin ...
        court.limits.yMax ...
        court.limits.zMin ...
        court.limits.zMax];
end