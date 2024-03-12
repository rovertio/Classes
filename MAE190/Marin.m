function [ka, kb, kc, kd, ke] = Marin(units, Sut, finish, shaft_d, temp, rel)
% Separate script for only finding the Marin factors associated with the
% endurance strength for the shaft at an iteration point

% Inputs: 
%   units       Desired unit system to use
%   Sut         Material ultimate tensile strength
%   finish      Surface specifications of th shaft
%   shaft_d     Shaft diameter (bigger one)
%   temp        Specified environment temperature
%   rel         Specified reliability desired
% Outputs: 
%   ka          Surface finish factor
%   kb          Size factor
%   kc          Laod factor
%   kd          Temperature factor
%   ke          Reliability factor


% ka value generation
if isequal(units, 'SI') % When using MPa
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
elseif isequal(units, 'Imperial') % When using ksi
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
ka = a*(Sut^b);
end 


% kb value generation


