%% Homework 2 / Midterm Code

syms x t1 t2 t3 L1 L2

T01 = TrM('sym', 0, 0, 0, t1);
T12 = TrM('deg', 90, L1, 0, t2);
T23 = TrM('sym', 0, L2, 0, t3);

T03 = T23*T12*T01;
simplify(T03)


%% Helper Functions

% Rotation matrix generator
function Rot = RotM(mes, axis, angle)

    if isequal(mes, 'deg')
        angle = angle*(pi/180);
    end
    
    if isequal(axis, 'x')
        Rot = [1, 0, 0;
            0, cos(angle), -sin(angle);
            0, sin(angle), cos(angle)];
    elseif isequal(axis, 'y')
        Rot = [cos(angle), 0, sin(angle);
            0, 1, 0;
            -sin(angle), 0, cos(angle)];
    elseif isequal(axis, 'z')
        Rot = [cos(angle), -sin(angle), 0;
            sin(angle), cos(angle), 0;
            0, 0, 1];
    end

end 



% Transformation matrix generator
function Tmat = TrM(mes, alpha, a, d_i, theta_i)

    if isequal(mes, 'deg')
        if ~isequal(class(alpha), 'sym')
            alpha = alpha*(sym(pi)/180);
        end
        if ~isequal(class(theta_i), 'sym')
            theta_i = theta_i*(sym(pi)/180);
        end
    end

    % Transformation matrix equation
    Tmat = [cos(theta_i), -sin(theta_i), 0, a;
        sin(theta_i)*cos(alpha), cos(theta_i)*cos(alpha), -sin(alpha), -sin(alpha)*d_i;
        sin(theta_i)*sin(alpha), cos(theta_i)*sin(alpha), cos(alpha), cos(alpha)*d_i;
        0, 0, 0, 1];

end 

