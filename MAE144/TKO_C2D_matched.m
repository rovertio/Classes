%% Solution code for question 3 of homework 2
% function [Dz] = TKO_C2D_matched(Ds, h, w_bar, c, s)
% Objective: Matched z transform: converts D(s) to D(z)
% Input options: 
%   Gs: symbolic format of the transfer function in continuous time
%   h: variable indicating time step used in the mapping
%   w_bar: (frequency of interest)
%   s: symbolic form of CT tf, variable used for s
%   c: variable controlling output of semi or strictly causal results
%       'st_c' gives strictly causal form, 'se_c' gives semi causal form
% Output options: Semi-casual or strictly-casual D(z)
% Assumes physically realisable system (more poles than zeros)


function [Dz] = TKO_C2D_matched(Ds, h, w_bar, c, s)
    % D(s)=(s+z1)/[s*(s+p1)], symbolic variables included
    % Through code and by hand
    % When z1 = 1, p1 = 10, compare generated answer within code to the matched
    % option used within MATLAB (c2d function)
    % code better?

    % Consider case of input as symbolics only
    if isa(Ds, 'sym') == 1 && nargin == 5
        sympref('FloatingPointOutput', true);
        [Gn,Gd] = numden(Ds); % Gives vector form of polynomials coefficients

        % Converting poles/zeroes and obtaining any zeroes added
        if length(coeffs(Gd,s)) > 1
            Gp = vpasolve(Gd,s); % Gets roots of denomiator (poles)
            Zp = exp(h.*Gp); % Converts roots to the z plane

            if ismember(0,Gp) == 1 && w_bar <= 0
                error('omega bar needs to be greater than 0');
            end
        end
        if length(coeffs(Gn,s)) > 1
            Gz = vpasolve(Gn,s); % Gets roots of numerator (zeroes)
            Zz = exp(h.*Gz); % Converts roots to the z plane
            if isequal(c, 'st_c')
                if length(Gp) - length(Gz) == 1
                    % no zeroes to add if already strictly proper
                    Zz_mod = Zz;
                else
                    % adds zeros to total to be one less than the pole
                    % number
                    Num_z = length(Gp) - length(Gz) - 1;
                    Zz_mod = [Zz', -ones(1,Num_z)];
                end
            elseif isequal(c, 'se_c')
                if length(Gp) - length(Gz) == 0
                    % no zeroes to add if already semi proper
                    Zz_mod = Zz;
                else
                    % adds zeros to total to be equal to the pole number
                    Num_z = length(Gp) - length(Gz);
                    Zz_mod = [Zz', -ones(1,Num_z)];
                end
            end
        else % when no zeroes (vpasolver gives error)
            if isequal(c, 'st_c')
                Num_z = length(Gp) - 1; % calculates number of zeros to add
                Zz_mod = -ones(1,Num_z);
            elseif isequal(c, 'se_c')
                Num_z = length(Gp);
                Zz_mod = -ones(1,Num_z);
            end
        end

        % Formulating polynomial expression, Z_rf
        syms z
        Z_denp = cumprod(z - Zp);
        Z_nump = cumprod(z- Zz_mod);
        Z_rf = (Z_nump(end))/(Z_denp(end));

        % Determining Gain at omega_bar
        Z_rf_bar = subs(Z_rf, z=exp(1i*w_bar*h));
        S_rf_bar = subs(Ds, s=1i*w_bar);
        K_mult = S_rf_bar/Z_rf_bar;

        % Returning the function
        Dz = (K_mult)*Z_rf;
    else
        error(['Error within the format of data entered. Please refer ' ...
            'to the documentation with help'])
    end 
end 

         