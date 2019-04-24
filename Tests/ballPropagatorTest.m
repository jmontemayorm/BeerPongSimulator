% Reset plots
close all

% Initial velocity and angles
v0 = 20; % [m/s]
el = pi/3; % [rad]
az = 0; % [rad]

% Environment
environment = struct;
environment.g = -9.81;
environment.dt = 0.01;

% Initial position
x0 = 0;
z0 = 0;

% Initialize ball
ball = createBall([x0 0 z0],az,el,v0,1);

% Time
finalTime = 3;
t = 0:environment.dt:finalTime;

% Analytic solution
vx0 = v0 * cos(el) * cos(az);
vz0 = v0 * sin(el);
aX = x0 + vx0 * t;
aZ = z0 + vz0 * t + 0.5 * environment.g * t.^2;

% Propagator solution
nX = zeros(size(aX));
nZ = nX;
nX(1) = x0;
nZ(1) = z0;
for idx = 2:length(nX)
    ball = propagateBall(ball,environment);
    nX(idx) = ball.PosX;
    nZ(idx) = ball.PosZ;
end

% Plot
plot(aX,aZ,'--')
hold on
plot(nX,nZ,':')