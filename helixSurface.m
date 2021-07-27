function body = helixSurface(ax, R, h, a, N_tot)
%helixSurface defines the surface of a 3-d helix along z axis as a mesh
%   R winding radius of helix
%   h pitch of helix (maybe)
%   a radius of wrapped cylinder

    syms Ts Us

    hel_x = R.*cos(Ts) - a.*cos(Ts).*cos(Us) + ((h^2+R^2)^-0.5)*h*a.*sin(Ts).*sin(Us);
    hel_y = R.*sin(Ts) - a.*sin(Ts).*cos(Us) - ((h^2+R^2)^-0.5)*h*a.*cos(Ts).*sin(Us);
    hel_z = h.*Ts + ((h^2+R^2)^-0.5)*R*a.*sin(Us);
    
    body = fsurf(ax, hel_x, hel_y, hel_z, [0, N_tot*2*pi]);
    
end

