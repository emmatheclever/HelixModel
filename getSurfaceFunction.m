function [X, Y, Z] = getSurfaceFunction(R, h, a)
%GETSURFACEFUNCTION produces the function S(t,u) = [X(t,u); Y(t,u); Z(t,u)]
%    describing the helical surface of the snake

syms x(t) y(t) z(t)
x(t) = R-a*cos(t);
y(t) = -(h*a*sin(t))*(R^2+h^2)^(-0.5);
z(t) = (R*a*sin(t))*(R^2+h^2)^(-0.5);

syms X(t, u) Y(t,u) Z(t,u)
X(t,u) = x(t)*cos(u) - y(t)*sin(u);
Y(t,u) = x(t)*sin(u) + y(t)*cos(u);
Z(t,u) = z(t) + h*u;

end

