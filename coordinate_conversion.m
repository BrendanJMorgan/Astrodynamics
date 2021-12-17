% function R = coordinate_conversion(r,l,t,type)
% latitude and sidereal time
% input in radians
% type 1 - GEC/TEC to THC
% type 2 - THC to GEC/TEC

function R = coordinate_conversion(r,l,t,type)
    
    matrix =    [-sin(t) cos(t) 0;
                -sin(l)*cos(t) -sin(l)*sin(t) cos(l)
                cos(l)*cos(t) cos(l)*sin(t) sin(l)];

    if type == 1
        R = matrix*r;
    elseif type == 2
        R = inv(matrix)*r;
    end

end