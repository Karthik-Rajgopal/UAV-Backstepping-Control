function F = Trim_sym(y)

global T qbar cbar S V b lz lx Ixcm Iycm Izcm Ixzcm Ixycm Iyzcm g mt xcm ycm zcm alpha_ beta_ Kmotor Sprop rho
d2r = pi/180;
r2d = 180/pi;
% u = y(1);
% v = y(2);
% w = y(3);
% deltae = y(4);
% delta = y(5);
% deltar = y(6);
% deltat = y(7);

alpha_ = atan(y(3)/y(1));
beta_ = asin(y(2)/V);
p =0;    
q = 0;   
r = 0;   
phi_ = 0;   
theta_ = alpha_;   
ptv =   0;  
ytv = 0;   



  % Start of aero data 

	
CD0 = 0.03;
 CDalpha = 0.30;
 CDQ=0;
 CDdeltae=0;
 CDP=0.0437;
 CD = (CD0+CDalpha*alpha_+CDdeltae*y(4)+(CDQ*cbar*q/(2*V))+(CDP*b*p/(2*V)));
 
 CY0=0;
 CYbeta = -0.98;
 CYP = 0;
 CYR = 0;
 CYdeltaa = 0;
 CYdeltar = -0.17;
 CY = (CY0+CYbeta*beta_+(CYP*b*p/(2*V))+(CYR*b*r/(2*V))+CYdeltaa*y(5)+CYdeltar*y(6));
 
CL0=0.28;
CLalpha = 3.45;
CLQ=0;
CLdeltae = -0.36;
CL = (CL0 + CLalpha*alpha_+CLdeltae*y(4)+(CLQ*cbar*q/(2*V)));
 
CM0 = -0.02338;
 CMalpha = -0.38;
 CMQ = -3.6;
 CMdeltae = -0.5;
 Cm = (CM0+CMalpha*alpha_+CMdeltae*y(4)+(CMQ*cbar*q/(2*V)));
  
 Cl0=0;
 Clbeta =-0.12*0.8;
 ClP = -0.26*0.8;
 ClR = 0.14*0.8;
 Cldeltaa = 0.08;
 Cldeltar = 0.105;
 Cl = (Cl0+Clbeta*beta_+(ClP*b*p/(2*V))+(ClR*b*r/(2*V))+Cldeltaa*y(5)+ Cldeltar*y(6));
 
Cn0=0;
  Cnbeta = 0.25*1.2;
 CnP = 0.022*1.2;
 CnR = -0.35*1.2;
 Cndeltaa = 0.06;
 Cndeltar = -0.032;
  Cn = (Cn0+Cnbeta*beta_+(CnP*b*p/(2*V))+(CnR*b*r/(2*V))+Cndeltaa*y(5)+Cndeltar*y(6));
 
  
 
%  Tx = y(7)*T*cos(ptv)*cos(ytv);
%  Ty = y(7)*T*sin(ytv);
%  Tz = -y(7)*T*sin(ptv)*cos(ytv);
 
  Tx = 0.5*rho*Sprop*(((Kmotor*y(7))^2)-V^2);
 Ty = 0;
 Tz = 0;
 
%  MTx = -lz*y(7)*T*sin(ytv);
%  MTy = lz*y(7)*T*cos(ptv)*cos(ytv)-lx*y(7)*T*sin(ptv)*cos(ytv);
%  MTz = -lx*y(7)*T*sin(ytv);

 MTx = 0;
 MTy = 0;
 MTz = 0;
 
  Cx = (-CD*cos(alpha_)*cos(beta_)-CY*cos(alpha_)*sin(beta_)+CL*sin(alpha_));
 Cy = (CY*cos(beta_)-CD*sin(beta_));
 Cz = (-CD*sin(alpha_)*cos(beta_)-CY*sin(alpha_)*sin(beta_)-CL*cos(alpha_));

 
I = [1 0 0 0 zcm -ycm;0 1 0 -zcm 0 xcm;0 0 1 ycm -xcm 0;0 -mt*zcm mt*ycm Ixcm -Ixycm -Ixzcm;mt*zcm 0 -mt*xcm -Ixycm Iycm -Iyzcm;-mt*ycm mt*xcm 0 -Ixzcm -Iyzcm Izcm];

eom_ = (inv(I))* [(-q*y(3)+r*y(2))+(q^2+r^2)*xcm-p*q*ycm-r*p*zcm-g*sin(theta_)+((qbar*S*Cx+Tx)/mt);
                 (-r*y(1)+p*y(3))+(r^2+p^2)*ycm-p*q*xcm-q*r*zcm+g*cos(theta_)*sin(phi_)+((qbar*S*Cy+Ty)/mt); 
                 (-p*y(2)+q*y(1))+(p^2+q^2)*zcm-r*p*xcm-q*r*ycm+g*cos(theta_)*cos(phi_)+((qbar*S*Cz+Tz)/mt);
                 Ixzcm*p*q+(Iycm-Izcm)*q*r-Ixycm*r*p+(q^2-r^2)*Iyzcm+(q*y(1)-p*y(2))*mt*ycm + (r*y(1)-p*y(3))*mt*zcm-zcm*mt*g*cos(theta_)*sin(phi_)+ycm*mt*g*cos(theta_)*cos(phi_)+(qbar*S*b*Cl)+MTx;
                 Ixycm*q*r+(Izcm-Ixcm)*r*p-Iyzcm*p*q+(r^2-p^2)*Ixzcm+(p*y(2)-q*y(1))*mt*xcm + (r*y(2)-q*y(3))*mt*zcm-zcm*mt*g*sin(theta_)-xcm*mt*g*cos(theta_)*cos(phi_)+(qbar*S*cbar*Cm)+MTy;
                 Iyzcm*r*p+(Ixcm-Iycm)*p*q-Ixzcm*q*r+(p^2-q^2)*Ixycm+(p*y(3)-r*y(1))*mt*xcm + (q*y(3)-r*y(2))*mt*ycm+ycm*mt*g*sin(theta_)+xcm*mt*g*cos(theta_)*sin(phi_)+(qbar*S*b*Cn)+MTz;];

 F(1) = eom_(1);
 F(2) = eom_(2);
 F(3) = eom_(3);
 F(4)= eom_(4);
 F(5)= eom_(5);
 F(6)= eom_(6);
 F(7)= (y(1)^2+y(2)^2+y(3)^2)-(V^2);
 

end