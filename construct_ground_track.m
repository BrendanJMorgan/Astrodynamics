% function ground_track = construct_ground_track(orbit, dt, long_aries)
% Ground track is [longitudes;latitudes]

function ground_track = construct_ground_track(orbit, dt, long_aries)

    earth_rotation = 2*pi/(23*3600+56*60); % rad/s
    
    % Construct latitude array
    lat = asin(orbit(3,:)./sqrt(orbit(1,:).^2 + orbit(2,:).^2 + orbit(3,:).^2));
    
    % Construct right ascension array
    RA = atan2(orbit(2,:),orbit(1,:));
    
    % Convert right ascension array to longitude array (i.e. correcting for Earth's rotation)
    long = zeros(1,length(RA));
    for i = 1:1:length(RA)
        long(i) = RA(i) - earth_rotation*dt*(i-1)-long_aries;
    end
    long = wrapToPi(long); % Longitude should fall between -180 and 180 degrees

    ground_track = [long;lat];

end