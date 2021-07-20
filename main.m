%%%%%%%%%%%%%% Drawing the Snake %%%%%%%%%%
% Emma Waters 7.14.2021

%%% Defining Constants
N_tot = 1.5          % # Rotations
N_seg = 7          % # Separators
a = 10              % radius of separators
N_mcK = 4           % # McKibben Muscles

% Colors of muscles in order
mcK_colors = {[0.25, 0.25, 0.25], [0.9100    0.4100    0.1700], [0.831, 0.831, 0.831],[0.25, 0.25, 0.25],[0.25, 0.25, 0.25], [0.811, 0.333, 0.027], [0.811, 0.333, 0.027]};

% Contraction coefficients for each muscle (column vector)
c_coeffs = [0.5; 0.5; 0; 0]

%%% Do you want to show body surface?
show_Body = 0

%%% paramter constraints and such
u_max = N_tot*2*pi;             % max u value
u_inc = u_max/(100);            % increments of u
u_vals = 0:u_inc:u_max;         % u values to plot
theta_m = 2*pi/N_mcK;           % angle between each muscle (counterclockwise, first muscle at 0*pi)

%%%Find Helix characteristics
% Winding radius
m_vecs = zeros(2, N_mcK)
for i = 1:N_mcK
    m_vecs(:,i) = a.*[cos((pi/2) - (i-1)*theta_m); sin((pi/2) - (i-1)*theta_m)]
end

R_vec = m_vecs*c_coeffs
R = norm(R_vec)
rot = acos(dot(R_vec, m_vecs(:,1)) / (R * a))                         % angle between m1 vector and normal vector

% pitch 
syms p
h = vpasolve(N_tot*pi*R == ((p*u_max+R)^1.5 - R^1.5)/(3*p), p)


%%%%%%% Plot Body Surface %%%%%%%%%%%%

%%% Setting up axes
f = figure(1)
clf(f,'reset')
ax = axes('Parent', f)
set(ax,'DataAspectRatio',[1 1 1])
box(ax, 'on')
hold on

%%% Plot surface/separators
if show_Body == 0
    body = plotSnakeSeparators(ax, R, h, a, u_max, N_seg);
else
    [hel_x, hel_y, hel_z] = helixSurface(R, h, a, N_tot);
    body = surf(ax, hel_x, hel_y, hel_z)
end

grid on
axis equal
axis padded
view(ax, 3)


%%% Helical Surface equations
syms x(t) y(t) z(t)
x(t) = R-a*cos(t)
y(t) = -(h*a*sin(t))*(R^2+h^2)^(-0.5)
z(t) = (R*a*sin(t))*(R^2+h^2)^(-0.5)

syms X(t, u) Y(t,u) Z(t,u)
X(t,u) = x(t)*cos(u) - y(t)*sin(u)
Y(t,u) = x(t)*sin(u) + y(t)*cos(u)
Z(t,u) = z(t) + h*u


%%% Plotting muscles
for m = 1:N_mcK
    
    if m < length(mcK_colors)
        color = mcK_colors{m}
    else
        color = [0.25, 0.25, 0.25]
    end
    
    plot3(ax, X(theta_m*(m-1) + rot, u_vals), Y(theta_m*(m-1) + rot, u_vals), Z(theta_m*(m-1) + rot, u_vals), "LineWidth", 8, "Color", color)
    
end
