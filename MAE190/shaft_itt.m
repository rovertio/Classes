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


% Initializing array for iterations
itt_array = zeros(1,20);
itt_array(1) = init;        % First is the guess for shaft diameter
ii = 1;

while conv_p > ccrit
    % Calcaulating larger diameter from the input smaller one
    end_D = shaft.geo.lsd* itt_array(ii);
    % Getting diameter from failure criteria specified
    [Kf, Kfs] = Stress_Con(itt_array(ii), end_D, shaft.geo.r, ...
        shaft.geo.name, shaft.mat_prop.Sut, shaft.mat_prop.name);
    [Se] = Marin(shaft.units, shaft.mat_prop.Sut, shaft.finish, end_D,...
        shaft.temperature, shaft.reliability);
    itt_array(ii+1) = criteria(shaft.criteria, shaft.Ma, shaft.Mm, ...
        shaft.Ta, shaft.Tm, Kf, Kfs, shaft.safety_n, shaft.mat_prop.Sy, ...
        shaft.mat_prop.Sut, Se);
    
    % Determining convergence
    conv_p = (1 - abs(itt_array(ii)/itt_array(ii-1)))*100;
    ii = ii + 1;
end
