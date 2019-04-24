function ball = propagateBall(ball,environment)
    % PROPAGATEBALL takes a ball struct and an environment struct and
    % propagates the ball position in one dt time unit.
        
    % Update positions
    ball.PosX = ball.PosX + ball.VelX * environment.dt;
    ball.PosY = ball.PosY + ball.VelY * environment.dt;
    ball.PosZ = ball.PosZ + ball.VelZ * environment.dt + 0.5 * environment.g * environment.dt^2;
    
    % Update z velocity
    ball.VelZ = ball.VelZ + environment.g * environment.dt;
end