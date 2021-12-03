

function [r,v] = KeplerianToCartesian(a,e,i,RAAN,arg,anom,mu)

    p = a*(1-e^2); % semilatus rectum
    r_0 = p / (1 + e * cos(anom));

    % position vector coordinates
    x = r_0 * cos(anom);
    y = r_0 * sin(anom);

    % velocity vector coordinates
    Vx_ = -(mu/p)^(1/2) * sin(anom);
    Vy_ = (mu/p)^(1/2) * (e + cos(anom));

    % position vector components X, Y, and Z
    X = (cos(RAAN) * cos(arg) - sin(RAAN) * sin(arg) * cos(i)) * x + (-cos(RAAN) * sin(arg) - sin(RAAN) * cos(arg) * cos(i)) * y;
    Y = (sin(RAAN) * cos(arg) + cos(RAAN) * sin(arg) * cos(i)) * x + (-sin(RAAN) * sin(arg) + cos(RAAN) * cos(arg) * cos(i)) * y;
    Z = (sin(arg) * sin(i)) * x + (cos(arg) * sin(i)) * y;
    % velocity vector components X', Y', and Z'
    Vx = (cos(RAAN) * cos(arg) - sin(RAAN) * sin(arg) * cos(i)) * Vx_ + (-cos(RAAN) * sin(arg) - sin(RAAN) * cos(arg) * cos(i)) * Vy_;
    Vy = (sin(RAAN) * cos(arg) + cos(RAAN) * sin(arg) * cos(i)) * Vx_ + (-sin(RAAN) * sin(arg) + cos(RAAN) * cos(arg) * cos(i)) * Vy_;
    Vz = (sin(arg) * sin(i)) * Vx_ + (cos(arg) * sin(i)) * Vy_;

    r = [X;Y;Z];
    v = [Vx;Vy;Vz];

end 