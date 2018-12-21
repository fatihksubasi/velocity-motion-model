
X1 = [0 0 -pi/10]; %initial pose
dt = 0.1; %time step
v = 2; %linear velocity
w = (pi/4); %angular velocity
n = 20; %number of samples
u = [v w]; %the velocity command

% Ideal motion plots
Xi = motion_model_ideal(X1, u, dt);
s = Xi;
for i=1:n
    Xi = motion_model_ideal(Xi, u, dt);
    quiver(Xi(1), Xi(2), cos(Xi(3)), sin(Xi(3)), 'AutoScaleFactor', 0.1);
    hold on;
end

function X = motion_model_ideal(X, u, dt)
    v = u(1);
    w = u(2);
    x = X(1);
    y = X(2);
    theta = X(3);

    xp = x - (v/w)*sin(theta) + (v/w)*sin(theta + w*dt);
    yp = y + (v/w)*cos(theta) - (v/w)*cos(theta + w*dt);
    thetap = theta + w*dt ;

    X = [xp, yp, thetap];
end
