%%%%%% Produces Necessary Data for Modelling snake in Blender %%%%%%%%%%
% To be used in "makeSpiral.py"
% Emma Waters, OSU LRAM, 8.13.2021
% github.com/emmatheclever

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  User Input here: %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Defining Constants
N_tot =  2            % # Rotations
N_seg =  6              % # Separators
a =      1              % radius of separators
N_mcK =  4              % # McKibben Muscles

%McKibben Info - Note: order of muscles is counterclockwise.
mcK_rest_length = 40    % length of unactuated muscle
mcK_act_length  = 28  % length at maximum contraction
mcK_colors = {[0.8, 0, 0], [0.654, 1, 0.121],[ 0.513, 0.427, 0.427], [0, 0.878, 0.682]}

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


theta_m = 2*pi/N_mcK;
m_vecs = getMuscleVecs(N_mcK, a, theta_m);

%Initialize data file:
data = fopen('blenderData.csv', 'wt');

for i = 1:length(frames)
    
    R_vec = getWindingRadius(m_vecs, frames{i});
    R = norm(R_vec);
    if R == 0
        rot = 0;          % angle between m1 vector and R_vec
    else 
        rot = acos(dot(R_vec, m_vecs(:,1)) / (R * a));
        if R_vec(1,1) < 0
            rot = 2*pi - rot;
        end
    end
    
    rot_matrix = [cos(rot) -1*sin(rot) 0;
                  sin(rot)  cos(rot)   0;
                  0         0          1];

    p = calculatePitch(R_vec, R, a, N_mcK, m_vecs, m_lengths_by_frame{i}, N_tot);
    
    [X, Y, Z] = getSurfaceFunction(R, p/(2*pi), a, rot_matrix);
    theta_s = getBaseOrientation(a, rot, X,Y,Z);
    
    fprintf(data, "%d,%d,%d,%d\n", theta_s, R_vec(1), R_vec(2), p);
    
end

fclose(data);