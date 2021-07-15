function [Dpsi_pos, Dpsi_neg] = calculate_Geodesic(xt, yt, zt , h, t_0, psi_0, Dpsi_0)
%CALCULATE_GEODESIC Calculates the geodesic along a helical surface given
%an initial point and angle:
%
%   Input:
%   x, y, z             symbolic parameterization of a cross section of the surface
%
%   h                   pitch of helix
%
%   t_0, psi_0          inital point (along the cross section); psi_0 =
%                        psi(t_0)
%
%   Dpsi_0              the initial angle between cross section and
%                        geodesic at initial point
%   Output:
%   geo_func            geo_func: t -> phi giving the geodesic              

x = xt(t_0)
y = yt(t_0)
z = zt(t_0)

Dx = diff(xt)
Dy = diff(yt)
Dz = diff(zt)

dx = Dx(t_0)
dy = Dy(t_0)
dz = Dz(t_0)

C_sym = (-1*dx*y + x*dy + h*dz + (x^2+y^2+h^2)*Dpsi_0)/(dx^2+dy^2+dz^2 + 2*(-1*dx*y + x*dy+h*dz)*Dpsi_0 + (x^2+y^2+h^2)*Dpsi_0^2)^0.5

C = double(C_sym)

Dpsi_pos = ((Dx*yt-xt*Dy-h*Dz)*(xt^2+yt^2+h^2-C^2)^0.5 + C*((xt*Dx+yt*Dy)^2+(xt*Dz-h*Dy)^2+(h*Dx+yt*Dz)^2)^0.5 ) / ((xt^2+yt^2+h^2)*(xt^2+yt^2+h^2-C^2)^0.5)
Dpsi_neg = ((Dx*yt-xt*Dy-h*Dz)*(xt^2+yt^2+h^2-C^2)^0.5 - C*((xt*Dx+yt*Dy)^2+(xt*Dz-h*Dy)^2+(h*Dx+yt*Dz)^2)^0.5 ) / ((xt^2+yt^2+h^2)*(xt^2+yt^2+h^2-C^2)^0.5)

syms t t_var

%geo_func_pos = int( Dpsi_pos, t, t_0, t_var) + psi_0
%geo_func_neg = int( Dpsi_neg, t, t_0, t_var) + psi_0

end

