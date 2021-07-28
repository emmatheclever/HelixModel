function m_lengths = calculateLengths(N_mcK, c_coeffs, long, short)
%UNTITLED estimates length of muscles based on c_coeffs (roughly %
%actuated). Admittedly not very precise.
    
    m_lengths = cell(1, N_mcK)
    delta = long - short
    
    for m = 1:N_mcK
        m_lengths{m} = ((1-c_coeffs(m)) * delta) + short
    end

end

