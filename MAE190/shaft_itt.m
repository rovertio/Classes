function [dia] = shaft_itt(shaft, init, ccrit)
% Function which depends on Stress_Con, Marin, vs_stress, and criteria
% functions to iterate and calculate a design diameter for a shaft using
% the input material data
% Input: structure shaft with following data
%   criteria        Failure criteria
%   surface_s       Surface finish
%   reliability     Specified reliability
%   temperature     Environmental temperature     
%   Ma              Moment amplitude
%   Mm              Moment mean
%   Ta              Torque amplitude
%   Tm              Torque mean
%   safety_n        Design factor of safety
%   mat_prop        Structure with yielding tensile, ultimate tensile and name
%   geo             Structure with geometry properties
% Input2: initial guess for shaft diameter (smaller)
% Outputs: 
%   dia         Shaft diameter after interations


if isequal(shaft.Unit_Choice, 'SI')
    Sy = shaft.Sy_SI;
    Sut = shaft.Sut_SI;
elseif isequal(shaft.Unit_Choice, 'Imperial')
    Sy = shaft.Sy_Imperial;
    Sut = shaft.Sut_Imperial;
end


% Initializing array for iterations
itt_array = zeros(1,20);
itt_array(1) = init;        % First is the guess for shaft diameter
ii = 1;
conv_p = 1;

while conv_p > ccrit
    % Calcaulating larger diameter from the input smaller one
    end_D = shaft.geo.lsd* itt_array(ii);
    % Getting diameter from failure criteria specified
    [Kf, Kfs] = Stress_Con(itt_array(ii), end_D, shaft.geo.r, ...
        shaft.geo.type, Sut, shaft.mat_prop.name);
    [Se] = Marin(shaft.Unit_Choice, Sut, shaft.machine_s, end_D,...
        shaft.temperature, shaft.reliability);
    itt_array(ii+1) = criteria(shaft.criteria, shaft.Ma, shaft.Mm, ...
        shaft.Ta, shaft.Tm, Kf, Kfs, shaft.safety_n, Sy, Sut, Se);
    
    % Determining convergence
    conv_p = (1 - abs(itt_array(ii+1)/itt_array(ii)))*100;
    ii = ii + 1;
end
