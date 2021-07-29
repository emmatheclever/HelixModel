%%%%%%%%%%%%%% Drawing the Snake %%%%%%%%%%
% Emma Waters, OSU LRAM, 7.28.2021
% github.com/emmatheclever

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  User Input here: %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Defining Constants
N_tot =  1.7            % # Rotations
N_seg =  6              % # Separators
a =      1             % radius of separators
N_mcK =  4              % # McKibben Muscles (must be at least 3)

%McKibben Info - Note: order of muscles is counterclockwise.
mcK_rest_length = 36    % length of unactuated muscle
mcK_act_length  = 25  % length at maximum contraction
mcK_colors = {[0.9100, 0.4100, 0.1700], [0.25, 0.25, 0.25], [0.25, 0.25, 0.25],[0.25, 0.25, 0.25],[0.25, 0.25, 0.25]}

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;0;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%m_lengths = calculateLengths(N_mcK, c_coeffs, mcK_rest_length, mcK_act_length)

%ax = createAxes(1)

%[muscles, body] = makeSnake(ax, N_tot, N_seg, a, N_mcK, mcK_colors, c_coeffs, m_lengths, show_Body)

% Cycling through one muscle contracting fully then relaxing fully over 100 frames:
frames = cell(1, 50);
for c = 1:25
    frames{c} = [c/25; 0; 0; 0];
end
for c = 26:50
    frames{c} = [(50 - c)/25; 0; 0; 0];
end

animateUpright(N_tot, N_seg, a, N_mcK, mcK_colors, frames, mcK_rest_length, mcK_act_length, show_Body)
