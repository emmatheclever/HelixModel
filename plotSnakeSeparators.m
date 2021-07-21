function body = plotSnakeSeparators(ax, R, h, a, t_max, N_seg)
%plotSnakeSeparators plots N_seg discs at even intervals along the length of
%helix defined by R, h, a, and t_max
%
%   R winding radius of helix
%   h pitch of helix (maybe)
%   a radius of wrapped cylinder

    t_inc = t_max/(N_seg-1)
    
    t = 0:t_inc:t_max;
    u = 0:0.1:2*pi;
    
    [T,U]=meshgrid(t,u);

    hel_x = R.*cos(T) - a.*cos(T).*cos(U) + ((h^2+R^2)^-0.5)*h*a.*sin(T).*sin(U);
    hel_y = R.*sin(T) - a.*sin(T).*cos(U) - ((h^2+R^2)^-0.5)*h*a.*cos(T).*sin(U);
    hel_z = h.*T + ((h^2+R^2)^-0.5)*R*a.*sin(U);
    
    body = plot3(ax, hel_x, hel_y, hel_z, "LineWidth", 2, 'Color', [17 17 17]/255)
    
end
