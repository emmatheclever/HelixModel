%%%%%%%%%%%%%% Testing Script %%%%%%%%%%
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
mcK_colors = {[0.9100, 0.4100, 0.1700], [0.788, 0.431, 0.431], [0.219, 0.309, 0.129],[0.25, 0.25, 0.25],[0.25, 0.25, 0.25],[0.8, 0, 0], [0.654, 1, 0.121], [0, 0.878, 0.682],[0, 0.250, 0.878],[0.443, 0.258, 0.878], [0.8, 0.180, 0.725]}

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;0;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% sawtooth concurrent, muscle 1 remaining at 0.5:
frames = cell(1, 41);
m_lengths_by_frame = cell(size(frames));
for c = 1:20
    frames{c} = [0;0;(20-(0.5*c))/20; (0.5*c + 10)/20]
    m_lengths_by_frame{c} = calculateLengths(N_mcK, frames{c}, mcK_rest_length, mcK_act_length);
end
for c = 20:41
    frames{c} = [0;0;(0.5*(c-20)+10)/20; (30-(c*0.5))/20]
    m_lengths_by_frame{c} = calculateLengths(N_mcK, frames{c}, mcK_rest_length, mcK_act_length);
end

animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, m_lengths_by_frame, show_Body, mcK_rest_length)