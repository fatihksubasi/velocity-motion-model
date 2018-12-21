
X1 = [0 0 -pi/10]; %initial pose
X2 = [3.2630 1.8274 1.3352]; %final pose
dt = 1; %time step
v = 2; %linear velocity
w = (pi/4); %angular velocity
n = 300; %number of samples
u = [v w]; %the velocity command

s = [];  
f = [];

% Noisy motion plots
for i=1:n
    noise = [sample_normal_dist(.001) sample_normal_dist(.1) sample_normal_dist(.001)];
    Xi = motion_model_noisy(X1, u, dt, noise);
    s = [s; Xi];  
    Xf = motion_model_noisy(X2, u, dt, noise);
    f = [f; Xf];
end

figure
scatter(f(:,1), f(:,2), 15, 'filled');  % Samples of final pose

function X = motion_model_noisy(X, u, dt, noise)
    v = u(1);
    w = u(2);
    x = X(1);
    y = X(2);
    theta = X(3);

    vp = v + noise(1);
    wp = w + noise(2);

    xp = x - (vp/wp)*sin(theta) + (vp/wp)*sin(theta + wp*dt);
    yp = y + (vp/wp)*cos(theta) - (vp/wp)*cos(theta + wp*dt);
    thetap = theta + wp*dt + noise(3)*dt;
    X = [xp, yp, thetap];  
end

function sample = sample_normal_dist(b)
    tot = 0;
    for i = 1:12
        tot = tot + normrnd(-b,b);
    end
    sample = 1/2 * tot;
end
