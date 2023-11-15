# Introduction 
Interest in the use of autonomous flight vehicles for defense as well as commercial applications has increased tremendously in recent years. Most UAVs in operation today are used for surveillance and reconnaissance (S&R) purposes and in very few cases for payload delivery. The absence of onboard qualified pilots in the case of UAVs offers the advantage of a reduction in weight and cost and plays a vital role in hazardous environments that are dangerous to human life. Traditionally, flight controllers have been designed based on a linearized aircraft model for a selected operating point. However, when the fight condition is changed, the model is no longer valid and the controller performance can be reduced. Also, UAV dynamics are inherently nonlinear. Nonlinear control techniques have been considered to overcome these difficulties. In this project, I've designed flight stability controllers for a fixed-wing UAV using the Backstepping approach under the guidance of Dr. Bijoy Krishna Mukherjee, a professor of the Department of EEE at BITS Pilani.  

# Backstepping Approach 
A variety of robust nonlinear control schemes have been presented in the literature that do not require the cancellation of all the nonlinearities. Backstepping is one such approach. Backstepping provides a novel way of recursively designing a controller by considering some of the states as a virtual control input. In this way, it simplifies the control design process for higher-order nonlinear systems such as aircraft. 

# Aircraft Model 
![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Aircraft%20Dynamics.jpg?raw=true)
* Translational Kinematic Equations 
  
  The translational kinematics equations are given below: 

  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Translational%20Kinematic%20Equations.jpg)
  
  where H is flight altitude, Y is lateral deviation wrt the runway, X is the horizontal displacement; u,v, and w are components of the velocity vector of UAV; phi, theta, psi are attitude angles (roll, pitch, and yaw respectively). 
* Translational Dynamic Equations

  The translational dynamic equations describing the components of the velocity relative to the UAV-based body-fixed reference frame are: 
  
  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Translational%20Dynamics%20Equations.jpg)
  
  where p,q,r are the roll, pitch, and yaw angular rates; g is gravitational constant, m is the mass of the UAV, Va is velocity magnitude of the UAV (Va = sqrt(u^2 + v^2 + w^2)), rho is air density (depending on altitude), S is wing area, b is wing span, c is aerodynamic mean chord; delt is throttle input (varying between 0 and 1), delr is rudder deflection, dele is elevator deflection.   
* Rotational Kinematic Equations 

  The rotational kinematic equations of the UAV are as follows: 
  
  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Rotational%20Kinematics%20Equation.jpg)
  
* Rotational Dynamic Equations
  
  The rotational dynamics equations describing roll, pitch, and yaw angular rates wrt UAV-based body-fixed frame reference frame are:
  
  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Rotational%20Dynamics%20Equation.jpg)
  
* Relationship between Components of the Velocity vector, Angle of attack, and Side Slip angles

  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Relationship%20btn%20V%2C%20alpha%20and%20Beta.jpg)
  
* Flight Path Angle Equation 

  ![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Flight%20Path%20Angle%20Eqn.jpg)  
  
**Note:** Only the important equations have been presented here. The equations for the aerodynamic constants can be found easily in any literature. I've used the equation for them from the book [Small Unmanned Aircraft (2012).pdf](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/files/9485598/Small.Unmanned.Aircraft.2012.pdf) by Randal W. Beard and Timothy W. McLain. 


# Controller & Observer Design 
The motion of the UAV is now divided into two parts while designing the controllers. One is in Lateral-Directional motion and the Other is in Longitudinal direction motion. The backstepping approach has been used to design the controllers. Both controllers will work simultaneously to provide the overall flight stability and desired motion. A wind observer has also been modeled for estimating wind disturbances.

The following image is a schematic of the controller and observer design for the UAV: 

![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Block%20Diagram.jpg)
* Lateral-Directional Controller

  Assumptions that we've taken while designing this controller: 
  
  * Aerodynamic angles - alpha and beta remain small.
  * Roll rate (p) remains small.
  * Pitch rate (q) remains very small during lateral-directional maneuvers.
  * Total velocity V is maintained constant 
  * Basically, while designing the Lateral-Directional Controller, **we’ve ignored the longitudinal dynamics.**
  
  **State variables:** phi, beta, p, r.
  
  **Control Inputs:** dela (aileron deflection) and delr (rudder deflection). 
  
* Longitudinal Controller

  While designing this controller, we'll ignore the lateral-directional dynamics.
  
  **State vectors:** v, alpha, gamma, theta, q.
  
  **Control Inputs:** delT (Throttle i/p - velocity controller) and delE (Elevator deflection - Flight path angle controller).
  
**Note:** For the equations of the Controllers, you can refer to the following presentation. 
https://docs.google.com/presentation/d/1c6U61U5BCYlcwXmJR-q57A_kSxaiEpe3V4xSZbWlwo0/edit#slide=id.g108a4b7ca6c_1_86

# Simulation Results 
The UAV was tested for a 180-degree horizontal turn maneuver. It was flying initially at a height of 1000 meters with an initial speed of 16.07m/s. The sideslip angle and Flight path angle were 0 initially. Wind disturbance has also been added as an external disturbance while designing the model. For simulation, three types of winds have been modeled - wind shears, atmospheric disturbances (described by the Dryden Spectral model - Wind turbulence), and wind gusts. 

For running the simulation model: 

![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Model%20Running%20Instructions.jpg)

* Download the "MATLAB & Simulink" Folder onto your computer. 
* Run the Trim_sym_main.m file first. 
* After this, run Constants_sym.m file. 
* Finally, open the Horizontal_Turn_Symmetric_DOP.mdl and then run the model.
* **Note:** Additionally, you'll be required to download Aerospace Blockset in order to run the Simulink model. 

The complete simulation model was developed using MATLAB & Simulink as shown in the image given below: 

![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Simulink%20Model.jpg)

The following image presents the simulation results for a 180-degree horizontal turn maneuver for the UAV. While performing the maneuver, a drop of 0.0001 meters in altitude and 0.6m/s in Velocity were observed. The UAV was successfully able to complete the maneuver with minimal errors, even in the presence of wind disturbance which proved the high performance and robustness of the controllers. 

![alt text](https://github.com/tusharsial/Flight-Dynamics-Controls-UAV-/blob/main/Images/Simulation%20Results.jpg)

# Simulation Video 
This video shows the simulation of the UAV performing a 180-degree horizontal turn maneuver. 

https://user-images.githubusercontent.com/74113713/188335543-a0279f09-67d2-4ec2-a6ab-815ede3acb67.mp4

# Future Scope
* Execution of minimum radius turn maneuver.
* Upgrading the model to include Center of Gravity Uncertainties. 
* Other Control Design techniques (like Sliding Mode Control, Adaptive Controllers, etc.) can be looked into in order to improve the performance. 
