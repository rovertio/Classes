%% Code used to output solutions for problem 3 of homework 1

% Setting values for freqeuncy, steps, and methods
h = 0.01;
w = 1;
opt = c2dOptions('Method','matched');

% Calculating symbolic answers
syms s
Ds_test = (s+z1)/(s*(s+p1));
help TKO_C2D_matched
[Dz_se_sym] = TKO_C2D_matched(Ds_test, h, w, 'se_c', s);
[Dz_st_sym] = TKO_C2D_matched(Ds_test, h, w, 'st_c', s);
Dz_se_sym
Dz_st_sym

% Calculating values with z1 = 1 and p1 = 10, and comparing them with the
% function in MATLAB
Ds_test2_val = (s+1)/(s*(s+10));
[Dz_se_val] = TKO_C2D_matched(Ds_test2_val, h, w, 'se_c', s);
[Dz_st_val] = TKO_C2D_matched(Ds_test2_val, h, w, 'st_c', s);
Dz_se_val
Dz_st_val
Ds_test2_tf = tf([1, 1], [1, 10, 0]);
c2d(Ds_test2_tf, h, opt)

