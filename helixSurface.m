function [hel_x, hel_y, hel_z] = helixSurface(R, h, a, N_tot)
%helixSurface defines the surface of a 3-d helix along z axis
%   R winding radius of helix
%   h pitch of helix (maybe)
%   a radius of wrapped cylinder

    t = 0:0.1:N_tot*2*pi;
    u = 0:0.1:2*pi;
    
    [T,U]=meshgrid(t,u);

    hel_x = R.*cos(T) - a.*cos(T).*cos(U) + ((h^2+R^2)^-0.5)*h*a.*sin(T).*sin(U)
    hel_y = R.*sin(T) - a.*sin(T).*cos(U) + ((h^2+R^2)^-0.5)*h*a.*cos(T).*sin(U)
    hel_z = h.*T + ((h^2+R^2)^-0.5)*R*a.*sin(U)
    
    
end

