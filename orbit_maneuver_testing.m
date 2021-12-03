pbaspect manual
format shortG

mu_earth = 3.986E5; % km3/s2
mu_sun = 1.327E11;
mu = mu_earth;

dt = 1; % s
total_time = 6*3600; % s

r = [7000;0;0];
v = [0;8;2];

orbit = propagate_orbit(r,v,dt,total_time,mu);
orbit = apply_impulse(orbit, 3*3600,[0;-2;2],mu);

%% 3D Orbit Plot
figure(1)
interval = 10; % Plot every nth point (saves computation)
plot3(orbit(1,1:interval:end),orbit(2,1:interval:end),orbit(3,1:interval:end));
ax = gca; 
ax.DataAspectRatio = [1 1 1];

max_dim = max([max(abs(orbit(1,:)));max(abs(orbit(2,:)));max(abs(orbit(3,:)))]);
xlim([-max_dim, max_dim]);
xlabel('X Axis (km)');
ylim([-max_dim, max_dim]);
ylabel('Y Axis (km)');
zlim([-max_dim, max_dim]);
zlabel('Z Axis (km)');

hold on

% Plot the Earth
img = imread('earth.png');
[X,Y,Z] = sphere(100);
X = X*6371;
Y = Y*6371;
Z = Z*6371;
warp(X,Y,-Z,img);
set(gca,'YDir','normal','Color',"#bfbfbf");

hold off
