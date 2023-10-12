%% Solution code for question 2, part b of homework 2
% Solution obtained in previous section has y(s) at a higher order than
% x(s), so the result is improper
% Problem find number of added poles at s = -20 to get proper answer

% Initialize values from previous problem
b = RR_poly([-2, 2, -5, 5],1);
a = RR_poly([-1, 1, -3, 3, -6, 6],1);
% f_pol defines vector for iterations
f_pol = [-1, -1, -3, -3, -6, -6];
f = RR_poly(f_pol,1);
[x,y] = RR_diophantine(a,b,f);
k = 0;

while y.n > x.n
    % adding another pole for another iteration
    f_pol(end+1) = -20;
    k = k + 1;

    % Generating the f polynomial
    f = RR_poly(f_pol,1);

    % Calling of the diophantine function to generate
    [x,y] = RR_diophantine(a,b,f);

end 

% Verifying solution of derived controller
test = trim(a*x+b*y);
residual = norm(f-test);


