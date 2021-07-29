function muscles = plotMuscles(ax, N_mcK, mcK_colors, X, Y, Z, u_max, theta_m, rot, m_width)
%PLOTMUSCLES Summary of this function goes here
%   Detailed explanation goes here

    
    u_inc = u_max/(100);
    u_vals = 0:u_inc:u_max;
    
    muscles = cell(1, N_mcK);
    
    for m = 1:N_mcK

        if m < length(mcK_colors)
            color = mcK_colors{m};
        else
            color = [0.25, 0.25, 0.25];
        end

        muscles{m} = plot3(ax, X(theta_m*(m-1) + rot, u_vals), Y(theta_m*(m-1) + rot, u_vals),...
            Z(theta_m*(m-1) + rot, u_vals), "LineWidth", m_width, "Color", color, 'Visible', 'off');
    end
    
end

