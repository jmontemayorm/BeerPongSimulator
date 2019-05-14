function ball = propagateBall(ball,environment)
    % PROPAGATEBALL takes a ball struct and an environment struct and
    % propagates the ball position in one dt time unit.
        
    % Update positions
    ball.posX = ball.posX + ball.velX * environment.dt;
    ball.posY = ball.posY + ball.velY * environment.dt;
    ball.posZ = ball.posZ + ball.velZ * environment.dt + 0.5 * environment.g * environment.dt^2;
    
    % Update z velocity
    ball.velZ = ball.velZ - environment.g * environment.dt;
end