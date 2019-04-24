function ball = createBall(p0,az,el,v0,player)
    % CREATEBALL takes an initial position vector, azimuthal and elevation
    % angles in radians, initial velocity, and player number and returns a
    % ball struct with position and speed.
    
    % Initialize ball as struct
    ball = struct;
    
    % Add initial position
    ball.PosX = p0(1);
    ball.PosY = p0(2);
    ball.PosZ = p0(3);
    
    % Mirror azimuthal angle for player 2
    if player == 2
        az = az + pi;
    end
    
    % Transform angles and velocity into speed
    vXY = v0 * cos(el);
    ball.VelX = vXY * cos(az);
    ball.VelY = vXY * sin(az);
    ball.VelZ = v0 * sin(el);
end