function ball = propagateBall(ball)
    % TODO: write description
    
    % Gravitational acceleartion on Earth
    g = 9.81;% [m/s]
    
    % Time delta
    dt = 0.01; % [s]
    
    % Update positions
    ball.PosX = ball.PosX + ball.VelX * dt;
    ball.PosY = ball.PosY + ball.VelY * dt;
    ball.PosZ = ball.PosZ + ball.VelZ * dt + 0.5 * g * dt^2;
    
    % Update z velocity
    ball.VelZ = ball.VelZ + g * dt;
end