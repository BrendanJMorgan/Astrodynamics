% function orbit_path = propagate_orbit(r,v,dt,duration,mu)
% Euler method
% Pass in r and v as column vectors

function orbit_path = propagate_orbit(r,v,dt,duration,mu)

    % time = 0:dt:duration;
    indices = round(duration/dt);
    orbit_path = zeros(3,indices);
    
    orbit_path(:,1) = r(:);

    for i = 2:1:indices
        
        r = orbit_path(:,i-1);
        -r/norm(r);
        acceleration = -r/norm(r) * mu/dot(r,r);
        v = v + acceleration*dt;
        r = r + v*dt;
        orbit_path(:,i) = r;
    end

end