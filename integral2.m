
function error_integral = integral2(E2,h,j)
error_integral = [0;0];

if j==15
    error_integral = [0;0];
else
    for k=0.1:0.1:j*10
        
        integral2 = 0.5*h*(E2(:,k)+E2(:,k-1));
        error_integral = error_integral + integral2;
    end
end    