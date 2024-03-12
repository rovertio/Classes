function [Kf, Kfs] = Stress_Con(shaft_d, end_d, geo_r, geo, Sut, mat)
% Separate script used soley for determining the stress concentrations of
% the shaft in the location specified for the program.

% Inputs: 
%   Shaft_d     Shaft iteration diameter
%   End_d       End shaft diameter
%   geo_r       Geometry radius
%   geo         Geometry type
%   Sut         Material ultimate tensile strength
%   Mat         Material name
% Outputs: 
%   Kf          Normal stress concentration factor
%   Kfs         Shear stress concentration factor

if isequal(mat, 'cast iron')
    q = 0.2;
    qs = 0.2;
else
    % Calculation of q: Notch sensitivity Axial/Bending
    roota_ax = 0.246 - 3.08*(10^-3)*Sut + 1.51*(10^-5)*Sut^2 ...
        - 2.67*(10^-8)*Sut^3;
    q = 1/(1 + (roota_ax/sqrt(Geo_d/2)));
    
    % Calculation of qs: Notch sensitivity Axial/Bending
    roota_sh = 0.190 - 2.51*(10^-3)*Sut + 1.35*(10^-5)*Sut^2 ...
        - 2.67*(10^-8)*Sut^3;
    qs = 1/(1 + (roota_sh/sqrt(geo_r/2)));
end


if isequal(geo, 'fillet')
    % From selected tabulated values for geometric values (moment)
    Dd_m = [6, 3, 2, 1.5, 1.2, 1.1, 1.07, 1.05, 1.03, 1.02, 1.01];
    A_m = [0.87868, 0.89334, 0.90879, 0.93836, 0.97098, 0.95120, ...
        0.97527, 0.98137, 0.98061, 0.96048, 0.91938];
    b_m = [-0.33243, -0.30860, -0.28598, -0.25759, -0.21796, -0.23757, ...
        -0.20958, -0.19653, -0.18381, -0.17711, -0.17032];
    % From selected tabulated values for geometric values (torsion)
    Dd_t = [2, 1.33, 1.2, 1.09];
    A_t = [0.86331, 0.84897, 0.83425, 0.90337];
    b_t = [-0.23865, -0.23161, -0.21649, -0.12692];

    % Metric for determining geometric properties
    Dod = shaft_d/end_d;

    % Calculation of Kt: Normal strength geometric factor
    A_mv = interp1(Dd_m, A_m, Dod);
    b_mv = interp1(Dd_m, b_m, Dod);
    Kt = A_mv*(geo_r/end_d)^(b_mv);
    
    % Calculation of Kts: Shear strength geometric factor
    A_tv = interp1(Dd_t, A_t, Dod);
    b_tv = interp1(Dd_t, b_t, Dod);
    Kts = A_tv*(geo_r/end_d)^(b_tv);

end


% Resulting stress concentration values
Kf = 1 + (q*(Kt - 1));
Kfs = 1 + (qs*(Kts - 1));

