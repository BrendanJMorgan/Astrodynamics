function orbit = apply_impulse(old_orbit,time,dv,mu)

    index = min(find(old_orbit(4,:) >= time));  % When does the impulse take place
    dt = old_orbit(4,2) - old_orbit(4,1);
    endtime = old_orbit(4,end);


    v_old = [(old_orbit(1,index) - old_orbit(1,index-1));
            (old_orbit(2,index) - old_orbit(2,index-1));
            (old_orbit(3,index) - old_orbit(3,index-1));
            ];
    v_old = v_old / (old_orbit(4,index) - old_orbit(4,index-1));
    
    v = v_old + dv;
    r = [old_orbit(1,index); old_orbit(2,index); old_orbit(3,index)];
    
    new_orbit = propagate_orbit(r,v,dt,endtime-index*dt,mu);

    orbit = old_orbit;
    orbit(1:3,index+1:end) = new_orbit(1:3,:);

    index
    length(old_orbit)
    length(orbit)
    length(new_orbit)
    
end