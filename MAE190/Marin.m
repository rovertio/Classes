function [Se] = Marin(units, Sut, finish, end_D, temp, rel)
% Separate script for only finding the Marin factors associated with the
% endurance strength for the shaft at an iteration point
% Inputs: 
%   units       Desired unit system to use  ('SI' or 'Imperial')
%   Sut         Material ultimate tensile strength
%   finish      Surface specifications of th shaft
%   end_D       End shaft diameter (bigger one)
%   temp        Specified environment temperature
%   rel         Specified reliability desired
% Outputs: 
%   Se          Endurance strength
%                   ka: Surface finish factor
%                   kb: assumes no axial through the desired analysis
%                   via this code script. Assumes circular cross-section
%                   kc: assumed to be 1 because of von mises stress
%                   kd: Through quadratic representative of
%                   tabulated values
%                   ke: linear interpolation between tabulated
%                   values


% ka and kb value generation
if isequal(units, 'SI') % When using MPa and mm
    % ka value generation
    if isequal(finish, 'ground')
        a = 1.58;
        b = -0.085;
    elseif isequal(finish, 'machined') || isequal(finish, 'cold-drawn')
        a = 4.51;
        b = -0.265;
    elseif isequal(finish, 'hot-rolled')
        a = 57.7;
        b = -0.718;
    elseif isequal(finish, 'as-forged')
        a = 272;
        b = -0.995;
    end

    % kb value generation
    if end_D >= 2.79 && end_D <= 51
        kb = 1.24*(end_D)^(-0.107);
    elseif end_D > 51 && end_D <= 254
        kb = 1.51*(end_D)^(-0.157);
    else
        kb = 1.51*(end_D)^(-0.157);
    end

    % kd temperature conversion: celsius to farenheit
    temp = (temp*(9/5)) + 32;

elseif isequal(units, 'Imperial') % When using ksi
    % ka value generation
    if isequal(finish, 'ground')
        a = 1.34;
        b = -0.085;
    elseif isequal(finish, 'machined') || isequal(finish, 'cold-drawn')
        a = 2.7;
        b = -0.265;
    elseif isequal(finish, 'hot-rolled')
        a = 14.4;
        b = -0.718;
    elseif isequal(finish, 'as-forged')
        a = 39.9;
        b = -0.995;
    end

    % kb value generation
    if end_D >= 0.11 && end_D <= 2
        kb = 0.879*(end_D)^(-0.107);
    elseif end_D > 2 && end_D <= 10
        kb = 0.91*(end_D)^(-0.157);
    else
        kb = 0.91*(end_D)^(-0.157);
    end

    temp = temp;

end 

% Final ka calculation
ka = a*(Sut^b);

% Final kd calculation with temperature
kd = 0.975 + 0.432*(10^(-3))*temp - 0.115*(10^(-5))*temp^2 ...
    + 0.104*(10^(-8))*temp^3 - 0.595*(10^(-12))*temp^4;


% kc value generation
kc = 1;         % Because von mises is utilized, can set to value of 1


% ke value generation
rel_p = [50, 90, 95, 99, 99.9, 99.99, 99.999, 99.9999];
ke_p = [1, 0.897, 0.868, 0.814, 0.753, 0.702, 0.659, 0.620];
ke = interp1(rel_p, ke_p, rel);


% Endurance strength calculation with resultant marin factors
Se = ka*kb*kc*kd*ke*(Sut/2);
