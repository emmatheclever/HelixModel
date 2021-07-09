%%%%%%%%%%%%%% Attempting to draw a corkscrew %%%%%%%%%%
% Emma Waters 7.1.2021


%%% Setting up axes
f = figure(1)
clf(f,'reset')
ax = axes('Parent', f)
set(ax,'DataAspectRatio',[1 1 1])
box(ax, 'on')

%%% Defining Constants
R = 1
h = 0.6
a = 1
N_tot = 3

%%% Getting points to plot
[hel_x, hel_y, hel_z] = helixSurface(R, h, a, N_tot)
r = surf(ax, hel_x, hel_y, hel_z)

