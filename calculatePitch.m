function [p_sol, l_v] = calculatePitch(R_vec, R, a, N_mcK, m_vecs, m_lengths, N_tot)
%CALCULATEPITCH Calculates Pitch using a muscle's length, radius, and
%number of turns.  If there is no muscle intersecting the separation disk
%along the normal vector of the base curve, a "virtual muscle" with
%estimated length is used.

    %Find closest muscle vectors to R_vec:
    min1 = Inf;
    min2 = Inf;
    closer = 0;
    closest = 1;
    
    for m = 1:N_mcK
        theta_R = acos(dot(R_vec, m_vecs(:,m)) / (R * a));
        
        if theta_R == 0
            closest = m;
            closer = 0;
            break
            
        elseif theta_R < min1
            min2 = min1;
            closer = closest;
            
            min1 = theta_R;
            closest = m;
            
        elseif theta_R < min2
            min2 = theta_R;
            closer = m;
            
        end 
    end
    
    
    %Find length of virtual muscle
    if  R < 1e-13
        l_v = min(cell2mat(m_lengths));
        
    elseif closer == 0                   %Easy if there's already a muscle on the normal vector
        l_v = m_lengths{closest};
        
    else                               %Otherwise we have to do some weird geometry things
        
        l1 = m_lengths{closest};
        l2 = m_lengths{closer};
        
        if l1 == l2
            l_v = l1;
        else
            y = min1*a;
            z = min2*a;

            x = l1*z/(l2-l1);

            l_v = l1*(x+y)/x;
        end
    end
    
    R_v = a - R;
    
    syms p positive
    p_sol = double(solve(l_v == N_tot*sqrt(p^2+(2*pi*R_v)^2), p, "Real", true));

end

