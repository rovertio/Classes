function [dia] = criteria(crit, Ma, Mm, Ta, Tm, Kf, Kfs, n, Sy, Sut, Se)
% Function for calculating the von mises stress from the applied/design
% loads onto the shaft
% Inputs: 
%   crit        Failure criteria
%   Ma          Moment amplitude
%   Mm          Moment mean
%   Ta          Torque amplitude
%   Tm          Torque mean
%   Kf          Stress concentration normal
%   Kfs         Stress concentration shear
%   n           Design factor of safety
%   Sy          Yielding tensile strength
%   Sut         Ultimate tensile strength
%   Se          Endurance strength
% Outputs: 
%   dia         iteration diameter


if isequal(crit, 'goodman')
    dia = (((16*n)/pi) * ((1/Se)*(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2)^(1/2) + ...
        (1/Sut)*(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2)^(1/2)))^(1/3);

elseif isequal(crit, 'de-gerber')
    A = sqrt(4*(Kf*Ma)^2 + 3*(Kfs*Ta)^2);
    B = sqrt(4*(Kf*Mm)^2 + 3*(Kfs*Tm)^2);

    dia = (((8*n*A)/(pi*Se))*(1 + (1 + ((2*B*Se)/(A*Sut))^2)^(1/2)))^(1/3);

elseif isequal(crit, 'de-asme elliptic')
    dia = ((((16*n)/pi))*(4*(Kf*Ma/Se)^2) + ...
        3*(Kfs*Ta/Se)^2 + ...
        4*(Kf*Mm/Sy)^2 + ...
        3*(Kfs*Tm/Sy)^2)^(1/3);
end

