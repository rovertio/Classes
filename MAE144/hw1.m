%% Solution code for question 2, part a of homework 2
% Problem: get controller to put poles at {-1, -1, -3, -3, -6, -6}


b = RR_poly([-2, 2, -5, 5],1);
a = RR_poly([-1, 1, -3, 3, -6, 6],1);
f = RR_poly([-1, -1, -3, -3, -6, -6],1);

% Calling of the diophantine function to generate
[x,y] = RR_diophantine(a,b,f)

% Verifying solution of derived controller
test = trim(a*x+b*y);
residual = norm(f-test);
