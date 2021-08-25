function separators = getSeparatorData(X, Y, Z, u_max, N_seg)
% getSeparatorData  gets plottable set of points for the specified number of 
% separator disks, evenly spaced.
%

    u_inc = u_max/(N_seg-1);
    T = 0:0.1:2.1*pi;
    
    separators = cell(N_seg,3);
    
    for s = 1:N_seg
        U = (s-1)*u_inc;
        separators{s,1} = X(T, U);
        separators{s,2} = Y(T, U);
        separators{s,3} = Z(T, U);
    end
    
end
