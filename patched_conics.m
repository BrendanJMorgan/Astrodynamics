pbaspect manual
format shortG

clear all
clf

begin_time = 0; % Seconds since 1/1/2000 0:00:00
duration = 86400*365.25;
dt = 3600;

[mu,r_ss,elements_ss] = initialize_solar_system(0,86400*365.25,3600);

starting_planet = 3; 

% spacecraft geocentric
r = [7000;0;0];
v = [0;13;0];
path = propagate_orbit(r,v,dt,duration,mu(starting_planet));
% path = path + r_ss(:,:,3);

r_SOI = elements_ss(1:8,1).*(mu(1:8)/mu(9)).^(2/5)
exit_index = min(find(vecnorm(path) >= r_SOI(starting_planet)))

plot_orbits(r_ss,10,'sun',0);
plot_orbits(path,10,'sun',0);  

hold off



