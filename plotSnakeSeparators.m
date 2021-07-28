function separators = plotSnakeSeparators(ax, X, Y, Z, u_max, N_seg)
%plotSnakeSeparators plots N_seg discs at even intervals along the length of
%helix defined by R, h, a, and t_max
%
%   R winding radius of helix
%   h pitch of helix (maybe)
%   a radius of wrapped cylinder

    u_inc = u_max/(N_seg-1)
    T = 0:0.1:2.1*pi;
    
    separators = cell(1, N_seg)
    
    for s = 1:N_seg
        U = (s-1)*u_inc;
        separators{s} = plot3(ax, X(T, U), Y(T, U), Z(T,U), "LineWidth", 3, 'Color', [17 17 17]/255);
    end
    
    view(ax,3)
    
end
