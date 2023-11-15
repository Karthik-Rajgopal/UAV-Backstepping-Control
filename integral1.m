
function error_integral = integral1(E1,h,j)
error_integral = [0;0];

if j==15
    error_integral = [0;0];
else
    for k=0.1:0.1:j*10
        
        integral1 = 0.5*h*(E1(:,k)+E1(:,k-1));
        error_integral = error_integral + integral1;
    end
end    