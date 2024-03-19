function [dia, itt_array, ii] = shaft_itt(shaft, init, ccrit)
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
%   itt_array   Values of diameter itterations
%   ii          Number of itterations


if isequal(shaft.Unit_Choice, 'SI')
    Sy = shaft.mat_prop.Sy_SI;
    Sut = shaft.mat_prop.Sut_SI;
elseif isequal(shaft.Unit_Choice, 'Imperial')
    Sy = shaft.mat_prop.Sy_Imperial;
    Sut = shaft.mat_prop.Sut_Imperial;
end


% Initializing array for iterations
itt_array = zeros(1,2);
itt_array(1) = init;        % First is the guess for shaft diameter
ii = 1;
conv_p = 1;

while conv_p > ccrit
    % Calcaulating larger diameter from the input smaller one
    end_D = shaft.geo.lsd* itt_array(ii);
    geo_radius = shaft.geo.r*itt_array(ii);

    % Getting diameter from failure criteria specified
    [Kf, Kfs] = Stress_Con(itt_array(ii), end_D, geo_radius, ...
        shaft.geo.type, Sut, shaft.mat_prop.name);
    [Se] = Marin(shaft.Unit_Choice, Sut, shaft.surface_s, end_D,...
        shaft.temperature, shaft.reliability);
     dia = criteria(shaft.criteria, shaft.Ma, shaft.Mm, ...
        shaft.Ta, shaft.Tm, Kf, Kfs, shaft.safety_n, Sy, Sut, Se);
     itt_array(ii+1) = dia;
    
    % Determining convergence
    conv_p = abs((itt_array(ii+1) - itt_array(ii))/itt_array(ii));
    ii = ii + 1;
end

% Check for yielding
[vsi_a, vsi_m, ny] = vs_stress(itt_array(end), shaft.Ma, shaft.Mm, ...
    shaft.Ta, shaft.Tm, Kf, Kfs, Sy);
if ny < 1
    disp('Shaft undergoes yielding: ny = ' + string(ny))
else
    disp('Shaft is safe from yielding: ny = ' + string(ny))
end



