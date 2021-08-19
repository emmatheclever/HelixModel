function [X_rot, Y_rot, Z_rot] = getSurfaceFunction(R, h, a, rot_matrix)
%GETSURFACEFUNCTION produces the function S(t,u) = [X(t,u); Y(t,u); Z(t,u)]
%    describing the helical surface of the snake

syms x(t) y(t) z(t)
z(t) = R-a*cos(t);
y(t) = -(h*a*sin(t))*(R^2+h^2)^(-0.5);
x(t) = (R*a*sin(t))*(R^2+h^2)^(-0.5);

syms X(t, u) Y(t,u) Z(t,u)
Z(t,u) = z(t)*cos(u) - y(t)*sin(u);
Y(t,u) = z(t)*sin(u) + y(t)*cos(u);
X(t,u) = x(t) + h*u;

syms X_rot(t,u) Y_rot(t,u) Z_rot(t,u)
funcs  = rot_matrix*[X(t,u); Y(t,u); Z(t,u)];
X_rot(t,u) = funcs(1,1);
Y_rot(t,u) = funcs(2,1);
Z_rot(t,u) = funcs(3,1);

end