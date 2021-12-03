% function mu, r, t = initialize_solar_system(start_time, duration, dt)

function [mu, r, elements] = initialize_solar_system(begin_time, duration, dt)
    
    times = round(duration/dt);

    mu = [
            0.022032e6  % Mercury
            0.32486e6   % Venus
            0.39860e6   % Earth
            0.042828e6  % Mars
            126.687e6   % Jupiter
            37.931e6    % Saturn
            5.7940e6    % Uranus
            6.8351e6    % Neptune
            132712e6    % Sun
            %0.00490e6   % Moon
        ];

    % a, e, i, longitude of ascending node, longitude of periapsis, mean longitude
    AU = 149598073; % km
    elements = zeros(length(mu), 6);
    elements(1,:) = [0.38709893*AU, 0.20563069, 7.00487*pi/180, 48.33167*pi/180, 77.45645*pi/180, 252.25084*pi/180];
    elements(2,:) = [0.72333199*AU, 0.00677323, 3.39471*pi/180, 76.68069*pi/180, 131.53298*pi/180, 181.97973*pi/180];
    elements(3,:) = [1.00000011*AU, 0.01671022, 0.00005*pi/180, -11.26064*pi/180, 102.94719*pi/180, 100.46435*pi/180];
    elements(4,:) = [1.52366231*AU, 0.09341233, 1.85061*pi/180, 49.57854*pi/180, 336.04084*pi/180, 355.45332*pi/180];
    elements(5,:) = [5.20336301*AU, 0.04839266, 1.30530*pi/180, 100.55615*pi/180, 14.75385*pi/180, 34.40438*pi/180];
    elements(6,:) = [9.53707032*AU, 0.05415060, 2.48446*pi/180, 113.71504*pi/180, 92.43194*pi/180, 49.94432*pi/180];
    elements(7,:) = [19.19126393*AU,0.04716771, 0.76986*pi/180, 74.22988*pi/180, 170.96424*pi/180, 313.23218*pi/180];
    elements(8,:) = [30.06896348*AU,0.00858587, 1.76917*pi/180, 131.72169*pi/180, 44.97135*pi/180, 304.88003*pi/180];
    elements(9,:) = [0*AU,0,0,0,0,0];

    r = zeros(4,times,length(mu));
    for i = 1:1:length(mu)
        r(:,:,i) = construct_orbit(elements(i,1), elements(i,2), elements(i,3), elements(i,4), elements(i,5), elements(i,6), mu(9), begin_time, duration, dt);
    end

end