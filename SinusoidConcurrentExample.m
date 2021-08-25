%%%%%%%%%%%%%% Sinusoidal Control of Snake %%%%%%%%%%
% Emma Waters, OSU LRAM, 8.5.2021
% github.com/emmatheclever

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  User Input here: %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Defining Constants
N_tot =  1.7            % # Rotations
N_seg =  6              % # Separators
a =      1              % radius of separators
N_mcK =  4              % # McKibben Muscles

%McKibben Info - Note: order of muscles is counterclockwise.
mcK_rest_length = 40    % length of unactuated muscle
mcK_act_length  = 28  % length at maximum contraction
mcK_colors = {[0.8, 0, 0], [0.654, 1, 0.121],[ 0.513, 0.427, 0.427], [0, 0.878, 0.682],[0, 0.250, 0.878],[0.513, 0.427, 0.427] ,[0.443, 0.258, 0.878], [0.513, 0.427, 0.42], [0.8, 0.180, 0.725]}

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;0;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Concurrent cycles:
period = N_mcK*10;
frames = cell(1, period+1);
m_lengths_by_frame = cell(size(frames));

for c = 1: (period+1)
    frames{c} = zeros(N_mcK, 1);
    for m = 1: N_mcK
        frames{c}(m) = 0.5*sin((2*pi/period)*(c + (m-1)*10))+1;
    end
    m_lengths_by_frame{c} = calculateLengths(N_mcK, frames{c}, mcK_rest_length, mcK_act_length);
end

animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, m_lengths_by_frame, show_Body,mcK_rest_length)
