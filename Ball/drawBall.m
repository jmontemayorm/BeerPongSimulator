function ball = drawBall(ball)
    % TODO: Add description
    
    ball.meshX = ball.baseMeshX + ball.posX;
    ball.meshY = ball.baseMeshY + ball.posY;
    ball.meshZ = ball.baseMeshZ + ball.posZ;
    
    ball.handler.XData = ball.meshX;
    ball.handler.YData = ball.meshY;
    ball.handler.ZData = ball.meshZ;
end

