function [muscles, body] = makeSnake(ax, N_tot, N_seg, a, m_vecs, N_mcK, mcK_colors, c_coeffs, m_lengths, show_Body)
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
    end

    [p, l_v] = calculatePitch(R_vec, R, a, N_mcK, m_vecs, m_lengths, N_tot);
    h = p/(2*pi);

    u_max = double(l_v/sqrt((R-a)^2+h^2));

    %%% Helical Surface equations
    [X, Y, Z] = getSurfaceFunction(R, h, a);

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
    muscles = plotMuscles(ax, N_mcK, mcK_colors, X, Y, Z, u_max, theta_m, rot, m_width);
    
    
    grid on
    view(ax, 3)


end

