function ball = createBall(networkOutput,court,player)
    % CREATEBALL takes an initial position vector, azimuthal and elevation
    % angles in radians, initial velocity, and player number and returns a
    % ball struct with position and speed.
    % TODO: Fix description
    
    % Shooting ranges
    minEl = deg2rad(10);
    maxEl = pi/3;
    maxAz = pi/12;
    minVel = 4;
    maxVel = 5;
    
    % Initialize ball as struct
    ball = struct;
    
    % Add initial position
    ball.posX = networkOutput(1) .* court.shootingZones.xSize + court.shootingZones.minX;
    if player == 2
        ball.posX = -ball.posX;
    end
    ball.posY = (networkOutput(2) - 0.5) .* court.shootingZones.ySize;
    ball.posZ = networkOutput(3) .* court.shootingZones.zSize + court.shootingZones.minZ;
    
    % Azimuthal angle
    az = maxAz * (networkOutput(4) - 0.5);
    if player == 2
        az = az + pi;
    end
    
    % Elevation angle
    el = (maxEl - minEl) * networkOutput(5) + minEl;
    
    % Initial speed
    v0 = (maxVel - minVel) * networkOutput(6) + minVel;
    
    % Transform angles and velocity into speed
    vXY = v0 * cos(el);
    ball.velX = vXY * cos(az);
    ball.velY = vXY * sin(az);
    ball.velZ = v0 * sin(el);
end