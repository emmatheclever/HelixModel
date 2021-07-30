function [muscle_Data, body, m_width] = makeSnake(ax, N_tot, N_seg, a, m_vecs, N_mcK, c_coeffs, m_lengths, show_Body)
%MAKESNAKE Calculates and plots snake for a set of contraction
%coefficients.

    %%% Some helpful variables
    theta_m = 2*pi/N_mcK;           % angle between each muscle (counterclockwise, first muscle at 0*pi)

    %%% Find Helix characteristics %%%%%%%%%%%%

    R_vec = getWindingRadius(m_vecs, c_coeffs);
    R = norm(R_vec);
    if R == 0
        rot = 0;          % angle between m1 vector and normal vector
    else 
        rot = acos(dot(R_vec, m_vecs(:,1)) / (R * a));
        if R_vec(1,1) < 0
            rot = 2*pi - rot;
        end
    end
    
    rot_matrix = [cos(rot) -1*sin(rot) 0;
                  sin(rot)  cos(rot)   0;
                  0         0          1];

    [p, l_v] = calculatePitch(R_vec, R, a, N_mcK, m_vecs, m_lengths, N_tot);
    h = p/(2*pi);

    u_max = double(l_v/sqrt((R-a)^2+h^2));

    %%% Helical Surface equations
    [X, Y, Z] = getSurfaceFunction(R, h, a, rot_matrix);

    %%%%%%% Plot Body Surface %%%%%%%%%%%%
    box(ax, 'on')
    hold on
    
    if show_Body == 0
        body = plotSnakeSeparators(ax, X, Y, Z, u_max, N_seg);
        m_width = 6;
    else
        body = fsurf(ax, X, Y, Z, [0 2*pi 0 u_max], 'Visible', 'off');
        m_width = 3;
    end

    %%% Plotting muscles
    muscle_Data = getMuscleData(N_mcK, X, Y, Z, u_max, rot, theta_m);
    
    
    grid on
    view(ax, 3)


end

