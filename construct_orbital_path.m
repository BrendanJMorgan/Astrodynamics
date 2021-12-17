% function orbit_path = construct_orbital_path(peri, apo, inc, RAAN, arg, true, dt, total_time)
% Generates the cartesian orbital path at every timestep
% Inputs in km, rad, s

function orbit_path = construct_orbital_path(elements, mu, begin_time, dt, total_time)
    a = elements(1);
    e = elements(2);
    inc = elements(3);
    RAAN = elements(4);
    arg = elements(5);
    true_anom = elements(6);

    time = 0:dt:total_time;         % Time array

    T = sqrt(4*pi^2*a^3/mu);        % Orbital Period
    M = (2*pi/T+true_anom)*time;    % Mean anomaly
    
    E = zeros(1,length(M));         % Eccentric anomaly
    for i = 1:1:length(E)
        E(i) = CalcEA(M(i),e);
    end
    
    theta = atan2((sin(E)*sqrt((1-e^2))),(cos(E)-e));   % True anomaly

    r = a*(1-e^2) ./ (1+e*cos(theta));  % Orbital radius at each point (function of true anomaly)
    
    % Euler rotations to find cartesian unit vectors, then scale by orbital radius r
    pos_x = r.*(cos(arg+theta)*cos(RAAN) - cos(inc)*sin(RAAN)*sin(arg+theta));
    pos_y = r.*(cos(arg+theta)*sin(RAAN) + cos(RAAN)*cos(inc)*sin(arg+theta));
    pos_z = r.*(sin(inc)*sin(arg+theta));
    
    orbit_path = [pos_x; pos_y; pos_z; time+begin_time];
end 

% https://www.mathworks.com/matlabcentral/fileexchange/6779-calce-m
% Converting mean anomaly to eccentric anomaly
function E = CalcEA(M,e,tolerance)      
    if nargin == 2
        %using default value
        tolerance = 10^-8;
    end
    
    Etemp = M;
    ratio = 1;
    while abs(ratio) > tolerance
        f_E = Etemp - e*sin(Etemp) - M;
        f_Eprime = 1 - e*cos(Etemp);
        ratio = f_E/f_Eprime;
        if abs(ratio) > tolerance
            Etemp = Etemp - ratio;
        else
            E = Etemp;
        end
    end
    
end