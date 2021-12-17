clear all
clf
pbaspect manual
format shortG

mu_earth = 3.986E5; % km3/s2
mu = mu_earth;
dt = 1; % s
duration = 2*3600; % s
long_aries = 0*pi/180;

% Phase 1
    a = 6371+200;
    e = 0;
    i = 28.5*pi/180;
    RAAN = 0*(-80.6077-90)*pi/180;
    arg = 0;
    anom = 90*pi/180;
    duration1 = 23*60; % s
[r,v] = KeplerianToCartesian(a,e,i,RAAN,arg,anom,mu);
orbit1 = propagate_orbit(r,v,dt,duration1,mu);

% Phase 2
    rp = 6371+200;
    ra = 42164;
    a = (rp+ra)/2;
    e = (ra-rp)/(ra+rp);
    i = -28.5*pi/180;
    RAAN = 0;
    arg = 0;
    anom = 0;
    duration2 = 5.5*3600; % s
[r,v] = KeplerianToCartesian(a,e,i,RAAN,arg,anom,mu);
orbit2 = propagate_orbit(r,v,dt,duration2,mu);

% Phase 3
    rp = 42164;
    ra = 42164;
    a = (rp+ra)/2;
    e = (ra-rp)/(ra+rp);
    i = 0*pi/180;
    RAAN = 180*pi/180;
    arg = 0;
    anom = 0;
    duration3 = 24*3600; % s
[r,v] = KeplerianToCartesian(a,e,i,RAAN,arg,anom,mu);
orbit3 = propagate_orbit(r,v,dt,duration3,mu);

orbit = [orbit1,orbit2,orbit3];
ground_track = construct_ground_track(orbit,dt,long_aries);

% Plotting
figure(1)
plot_ground_track(ground_track);
hold off

figure(2)
plot_orbits(orbit,1:1:1000,'earth',0);
hold off
