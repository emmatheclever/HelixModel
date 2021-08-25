%%%%%%%%%%%%%% Animating a Single Muscle Actuating Fully %%%%%%%%%%
% Emma Waters, OSU LRAM, 7.29.2021
% github.com/emmatheclever

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  User Input here: %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Defining Constants
N_tot =  1.7            % # Rotations
N_seg =  6              % # Separators
a =      1              % radius of separators
N_mcK =  4              % # McKibben Muscles (must be at least 3)

%McKibben Info - Note: order of muscles is counterclockwise.
mcK_rest_length = 36    % length of unactuated muscle
mcK_act_length  = 28  % length at maximum contraction
mcK_colors = {[0.9100, 0.4100, 0.1700], [0.788, 0.431, 0.431], [0.219, 0.309, 0.129],[0.25, 0.25, 0.25],[0.25, 0.25, 0.25]}

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;0;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cycling through one muscle contracting fully, then relaxing fully, over 100 frames:
frames = cell(1, 50);
m_lengths_by_frame = cell(size(frames))
for c = 1:25
    frames{c} = [0; 0; 0; c/25];
    m_lengths_by_frame{c} = calculateLengths(N_mcK, frames{c}, mcK_rest_length, mcK_act_length);
end
for c = 26:50
    frames{c} = [0; 0; 0; (50 - c)/25];
    m_lengths_by_frame{c} = calculateLengths(N_mcK, frames{c}, mcK_rest_length, mcK_act_length);
end

animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, m_lengths_by_frame, show_Body, mcK_rest_length)
