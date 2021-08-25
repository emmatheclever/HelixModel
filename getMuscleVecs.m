function m_vecs = getMuscleVecs(N_mcK, a, theta_m)
% GETMUSCLEVECS calculates muscle vectors, first muscle at [0; a], order is
%   counterclockwise
%
%   N_mcK   number of mcKibben muscles
%   a       radius of separation disks
%   theta_m angle between evenly spaced muscles 

    m_vecs = zeros(2, N_mcK);
    for i = 1:N_mcK
        m_vecs(:,i) = a.*[cos((pi/2) - (i-1)*theta_m); sin((pi/2) - (i-1)*theta_m)];
    end

end