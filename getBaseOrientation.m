function theta_s = getBaseOrientation(a, rot, X,Y,Z)
%GETBASEORIENTATION Calculates the rotation and center of the base
%separator disk (only used for generating data for Blender)

    rot_Z = [cos(rot) -1*sin(rot) 0;
             sin(rot)  cos(rot)   0;
             0       0        1];
    n = -1 .* rot_Z * [a; 0; 0];
    
    ref = rot_Z * [0;a;0];
    
    theta_t = rot + pi;
    low = [X(theta_t,0); Y(theta_t, 0); Z(theta_t,0)];
    
    tilt = low + n;
    
    theta_s = double(acos(dot(ref, tilt) / (norm(ref) * norm(tilt))));

end