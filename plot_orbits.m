% function plot_orbits(r, interval, parent, rotation)
% parent = 'sun' or 'earth'


function plot_orbits(r, interval, parent, rotation)
    hold on

    AU = 149598073; % km

    for i = 1:1:length(r(1,1,:))
        r_cur = r(:,:,i);
        plot3(r_cur(1,1:interval:end), r_cur(2,1:interval:end), r_cur(3,1:interval:end));
    end

    ax = gca; 
    ax.DataAspectRatio = [1 1 1];
    
    max_dim = max(r(1:3,:,:), [], 'all'); 
    xlim([-max_dim, max_dim]);
    xlabel('X Axis (km)');
    ylim([-max_dim, max_dim]);
    ylabel('Y Axis (km)');
    zlim([-max_dim, max_dim]);
    zlabel('Z Axis (km)');
    
    if parent == 'sun'
        % Plot the Sun
        radius = 695700;
        img = imread('sun.jpg');
    elseif parent == 'earth'
        % Plot the Earth
        radius = 6371;
        img = imread('earth.png');
    end

    [X,Y,Z] = sphere(100);
    X_ = X*radius;
    Y_ = Y*radius;
    X = X_*cos(rotation) - Y_*sin(rotation);
    Y = X_*sin(rotation) + Y_*cos(rotation);
    Z = Z*radius;
    warp(X,Y,-Z,img);
    set(gca,'YDir','normal');

end