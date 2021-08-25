function R_vec = newRadius(m_vecs, c_coeffs, m_lengths, N_tot)
%NE Summary of this function goes here
%   Detailed explanation goes here
    
    weights = zeros(size(c_coeffs));
    l_avg = sum([m_lengths{:}])/length(m_lengths);
    
    for i =1:length(weights)
        weights(i) = (l_avg-m_lengths{i}) * c_coeffs(i)/(N_tot);
    end

    if sum(c_coeffs) == 0
        R_vec = [0; 0];
        
    else
        R_vec = (m_vecs*weights);
    end

end

