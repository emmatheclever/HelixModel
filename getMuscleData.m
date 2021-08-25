function muscle_Data = getMuscleData(N_mcK, X, Y, Z, u_max, rot, theta_m)
%getMuscleData  returns a set of points along each muscle for plotting.

    
    u_inc = u_max/(100);
    u_vals = 0:u_inc:u_max;
    
    muscle_Data = cell(N_mcK, 3);
    
    for m = 1:N_mcK
        muscle_Data{m,1} = X(theta_m*(m-1) - rot, u_vals);
        muscle_Data{m,2} = Y(theta_m*(m-1) - rot, u_vals);
        muscle_Data{m,3} = Z(theta_m*(m-1) - rot, u_vals);
    end
    
end

