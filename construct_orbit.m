% function orbit_path = construct_orbital_path(peri, apo, inc, RAAN, arg, true, dt, total_time)
% Generates the cartesian orbital path at every timestep
% Inputs in km, rad, s
% Orbital elements are inputted at time = 0, may be different from begin_time

function orbit_path = construct_orbit(a, e, inc, RAAN, arg, true_anom, mu, begin_time, duration, dt)
   
    time = begin_time+dt:dt:duration;         % Time array

    T = sqrt(4*pi^2*a^3/mu);  % Orbital Period
    E = 2 * atan2( tan(true_anom/2), sqrt((1+e)/(1-e)) );
    M = E - e*sin(E);
    M = wrapTo2Pi(2*pi/T*time + M); % Mean anomaly
    
    E = zeros(1,length(M));     % Eccentric anomaly
    for i = 1:1:length(E)
        E(i) = CalcEA(M(i),e,10^-8);
    end
    
    theta = atan2((sin(E)*sqrt((1-e^2))),(cos(E)-e));   % True anomaly

    r = a*(1-e^2) ./ (1+e*cos(theta));  % Orbital radius at each point (function of true anomaly)
    
    % Euler rotations to find cartesian unit vectors, then scale by orbital radius r
    pos_x = r.*(cos(arg+theta)*cos(RAAN) - cos(inc)*sin(RAAN)*sin(arg+theta));
    pos_y = r.*(cos(arg+theta)*sin(RAAN) + cos(RAAN)*cos(inc)*sin(arg+theta));
    pos_z = r.*(sin(inc)*sin(arg+theta));
    
    orbit_path = [pos_x; pos_y; pos_z; time];

end 

% https://www.mathworks.com/matlabcentral/fileexchange/6779-calce-m
% Converting mean anomaly to eccentric anomaly
function E = CalcEA(M,e,tolerance)    
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