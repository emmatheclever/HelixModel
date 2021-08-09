function R_vec = getWindingRadius(m_vecs, c_coeffs)
%GETWINDINGRADIUS Returns vector form of winding radius
    
    square_c = c_coeffs.^2;
    
    if sum(c_coeffs) == 0
        R_vec = [0; 0];
        
    else
        R_vec = (m_vecs*square_c)./sum(c_coeffs);
    end
    
end