%%%%%%%%%%%%%% Drawing the Snake %%%%%%%%%%
% Emma Waters, OSU LRAM, 7.21.2021
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
mcK_act_length  = 26  % length at maximum contraction
mcK_colors = {[0.9100, 0.4100, 0.1700], [0.25, 0.25, 0.25], [0.25, 0.25, 0.25],[0.25, 0.25, 0.25],[0.25, 0.25, 0.25]}

% Contraction coefficients for each muscle (column vector)
c_coeffs = [1;0;0;0]

%%% Do you want to show body surface?
show_Body = 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Run this now.... %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Some helpful variables
m_lengths = calculateLengths(N_mcK, c_coeffs, mcK_rest_length, mcK_act_length)
theta_m = 2*pi/N_mcK;           % angle between each muscle (counterclockwise, first muscle at 0*pi)

%%% Find Helix characteristics %%%%%%%%%%%%
m_vecs = getMuscleVecs(N_mcK, a, theta_m)

R_vec = getWindingRadius(m_vecs, c_coeffs)
R = norm(R_vec)      
if R == 0
    rot = 0          % angle between m1 vector and normal vector
else 
    rot = acos(dot(R_vec, m_vecs(:,1)) / (R * a))
end

[p, l_v] = calculatePitch(R_vec, R, a, N_mcK, m_vecs, m_lengths, N_tot)
h = p/(2*pi)

u_max = l_v/sqrt((R-a)^2+h^2)

%%% Helical Surface equations
[X, Y, Z] = getSurfaceFunction(R, h, a)

%%%%%%% Plot Body Surface %%%%%%%%%%%%
ax = createAxes(1)
box(ax, 'on')
hold on

%%% Plot surface/separatorsu
if show_Body == 0
    body = plotSnakeSeparators(ax, X, Y, Z, u_max, N_seg);
    m_width = 6
else
    body = fmesh(ax, X, Y, Z, [0, 2*pi, 0, u_max]);
    m_width = 3
end

grid on
axis equal
axis padded
view(ax, 3)

%%% Plotting muscles
muscles = plotMuscles(ax, N_mcK, mcK_colors, X, Y, Z, u_max, theta_m, rot, m_width)
    
