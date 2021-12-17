% clear all
% clf
pbaspect manual

mu_earth = 3.986E5; % km3/s2
dt = 1; % s
total_time = 1.1*86400; % s

% Molniya Orbit
rp = 7000; %km
ra = 46220; %km
a = (rp+ra)/2;
e = (ra-rp)/(ra+rp);
i = 63.4*pi/180;
RAAN = -30*pi/180;
arg = -90*pi/180;
anom = 0;

% % Tundra Orbit
% a = 42240; % km
% e = 0.3;
% i = 63.4*pi/180;
% RAAN = 0*pi/180;
% arg = -90*pi/180;
% anom = 0;

orbit = construct_orbital_path([a,e,i,RAAN,arg,anom],mu_earth,0,dt,total_time);
ground_track = construct_ground_track(orbit,dt,0);

%% 2D Ground Track Plot
figure(1)
img = imread('earth.png');
image('CData',img,'XData',[-180 180],'YData',[90 -90])
hold on

ground_track = ground_track*180/pi;
scatter(ground_track(:,1),ground_track(:,2),1);
axis equal
xlabel('longitude');
ylabel('latitude');
xlim([-180 180]);
ylim([-90 90]);

hold off

%% 3D Orbit Plot
figure(2)
plot3(orbit(:,1),orbit(:,2),orbit(:,3));
ax = gca; 
ax.DataAspectRatio = [1 1 1];

max_dim = max([max(abs(orbit(:,1)));max(abs(orbit(:,2)));max(abs(orbit(:,3)))]);
xlim([-max_dim, max_dim]);
xlabel('X Axis');
ylim([-max_dim, max_dim]);
ylabel('Y Axis');
zlim([-max_dim, max_dim]);
zlabel('Z Axis');

hold on

% Plot the Earth
[X,Y,Z] = sphere(100);
X = X*6371;
Y = Y*6371;
Z = Z*6371;
warp(X,-Y,-Z,img);

hold off
