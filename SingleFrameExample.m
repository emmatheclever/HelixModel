%%%%% Plot a single configuration %%%%%%%%%%
% Emma Waters, OSU LRAM, 8.5.2021
% github.com/emmatheclever

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  User Input here: %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Defining Constants
N_tot =  3            % # Rotations
N_seg =  6              % # Separators
a =      1             % radius of separators
N_mcK =  4             % # McKibben Muscles

%McKibben Info - Note: order of muscles is counterclockwise.
mcK_rest_length = 36    % length of unactuated muscle
mcK_act_length  = 28  % length at maximum contraction
mcK_colors = {[0, 0, 0], [0.843, 0.247, 0.035], [0.654, 0.674, 0.635],[0, 0.521, 0.607],[0.25, 0.25, 0.25],[0.8, 0, 0], [0.654, 1, 0.121], [0, 0.878, 0.682],[0, 0.250, 0.878],[0.443, 0.258, 0.878], [0.8, 0.180, 0.725]};

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;1;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

theta_m = 2*pi/N_mcK;
m_vecs = getMuscleVecs(N_mcK, a, theta_m);
m_lengths = calculateLengths(N_mcK, c_coeffs, mcK_rest_length, mcK_act_length)

[muscle_Data, separators, m_width] = makeSnake(N_tot, N_seg, a, m_vecs, N_mcK, c_coeffs, m_lengths, show_Body);

fig = figure();
ax = createAxes(fig);
grid on
box(ax, 'on')
hold on
view(ax, 3)

syms p positive
p_sol = solve(mcK_rest_length == N_tot*sqrt(p^2+(2*pi*a)^2), p);
s_len = double(p_sol*N_tot)*1.1;

zlim([-a*4 a*4])
ylim([-a*4 a*4])
xlim([-a*2 35])

if show_Body == 0
    body = cell(1, N_seg);
    for s = 1:N_seg
        body{s} = plot3(ax, separators{s,1}, separators{s,2}, separators{s,3}, "LineWidth", 3, 'Color', [17 17 17]/255);
    end
else
    body = fmesh(ax, separators{1}, separators{2}, separators{3}, [0 2*pi 0 separators{4}]);
end

muscles = cell(1, N_mcK);
for m = 1:N_mcK
    muscles{m} = plot3(ax, muscle_Data{m,1}, muscle_Data{m,2}, muscle_Data{m,3}, 'Color', mcK_colors{m}, 'LineWidth', m_width);
end

