function [nkHelixX,nkHelixY, nkHelixZ] = nikiKovaHelix(R, h, a)
%NIKIKOVAHELIX Summary of this function goes here
%   Detailed explanation goes here

%{
    nkHelixX = @(u) R - a*cos(u)
    nkHelixY = @(u) -1*h*a*sin(u)*(R^2+h^2)^(-0.5)
    nkHelixZ = @(u) R*a*sin(u)*(R^2+h^2)^(-0.5)
%}

    nkHelixX = @(u) cos(u)-sin(u)
    nkHelixY = @(u) sin(u)-cos(u)
    nkHelixZ = @(u) h*u


end

