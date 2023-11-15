clc;clear all;


d2r = pi/180;
r2d = 180/pi;


load('Trim_sym.mat')

delE = y(4);
delA = y(5);
delR = y(6);
delT = y(7);

delPTV = 0;
delYTV = 0;



% Actuator bandwidth = 10hz
actFreqHz = 10;
actBW = (2*pi*actFreqHz);


% V = 150; % velocity (in m/s)
% beta_ = 0;

%% CONSTANTS
% Geometric / mass properties data
g = 9.81; 
% ALT = 2000; % altitude (in m)

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
% 
rho = p_atm/(287*T_atm);
% rho=1.2682;
rho_sl = 1.225; % density @ sea-level (kg/m3)
Sprop = 0.2027;
Kmotor = 80;
Cprop = 1;
T = 0.5*rho*Sprop*Cprop*(((Kmotor*delT)^2)-V^2);


 m = 13.5;
 W = m*g;
 S = 0.55;
 qbar = 0.5*rho*V^2;
 cbar = 0.18994;
b = 2.8956; % ft -> m  
Ixx = 0.8244; % slugs ft2 -> Kg m2
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
ctheta = 1/sqrt(1+alpha_^2); % cos(theta), this is theta is the phi, theta, psi one.
stheta = alpha_/sqrt(1+alpha_^2); %sin(theta)



% [xcm, ycm, zcm] = deal(COM(1), COM(2), COM(3));
% I_vec = [Ixcm, Iycm, Izcm, Ixycm, Iyzcm, Ixzcm];


