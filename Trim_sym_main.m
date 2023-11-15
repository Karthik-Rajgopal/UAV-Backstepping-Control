close all
clear all
clc

global T qbar cbar S V b lz lx Ixcm Iycm Izcm Ixzcm Ixycm Iyzcm g mt m xcm ycm zcm alpha_ beta_ m0 Kmotor Sprop rho

d2r = pi/180;
r2d = 180/pi;
g = 9.81; 

ALT = 1000; % altitude (in m)
V = 16.07; % velocity (in m/s)
% max_thrust = 32000*g/2.2046;
if (ALT <= 11000) 
   T_atm = 288.15-0.0065*ALT; % atmospheric temp.(in Kelvin)
   p_atm = 101325*(T_atm/288.15)^(9.81/(287*0.0065));  % atmospheric pressure (pascal)
else 
   T_atm = 216.65;
   p_atm = 22632*exp(-9.81*(ALT-11000)/(287*216.65)); 
end   
R1 = 287.1;  % Gas constant (m2/s2/K)
ss = sqrt(1.4*R1*T_atm); % sound velocity (m/s)
 M = V/ss;

rho = p_atm/(287*T_atm);
% rho=1.2682;
rho_sl = 1.225; % density @ sea-level (kg/m3)
Sprop = 0.2027;
Kmotor = 80;
Cprop = 1;
% T = 0.5*rho*Sprop*Cprop*(((Kmotor*0.3)^2)-V^2);
% % T = max_thrust * (rho / rho_sl)^0.7 * (1 - exp((ALT - 17000) / 2000));
% T = 0.9*max_thrust*(0.88+0.24*(abs(M-0.6))^1.4)*(rho/rho_sl)^0.8;

 m = 13.5;
 W = m*g;
% lz = 0;
% lx = 0;
 S = 0.55;
 qbar = 0.5*rho*V^2;
 cbar = 0.18994;
 b = 2.8956;
 Ixx = 0.8244; %  Kg m2
Iyy = 1.135;
Izz = 1.759;
Ixz = 0.1204;
Ixy = 0;
Iyz = 0;
m0= 0;    %Kg
mt = m+m0;  %Kg
x0 = 0;  %m
y0 = 0;  %m
z0 = 0; %m
xcm = (m0*x0)/mt; %m
ycm = (m0*y0)/mt; %m
zcm = (m0*z0)/mt; %m
Ixcm = Ixx +m0*(y0^2+z0^2);
Iycm = Iyy +m0*(z0^2+x0^2);
Izcm = Izz +m0*(x0^2+y0^2);
Ixzcm = Ixz + m0*(x0*z0);
Ixycm = Ixy + m0*(x0*y0);
Iyzcm = Iyz + m0*(y0*z0);
COM = [x0,y0,z0];




 
[y,fval]=fsolve(@Trim_sym,[20 0 4 0.1 0.01 0.01 0.1])


save('Trim_sym.mat','y','ALT','V','alpha_','beta_', 'COM', 'mt', 'Ixcm', 'Iycm', 'Izcm', 'Ixzcm', 'Ixycm', 'Iyzcm')
format short
% clear variables

delta_ear = y(4:6)*r2d
AOA = atan(y(3)/y(1))*r2d
SSA = asin(y(2)/(sqrt(y(1)^2+y(2)^2+y(3)^2)))*r2d
throttle = y(7)


