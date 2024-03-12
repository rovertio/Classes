% UserInput.m --> File made to facilitate shaft design of the user:
%     - Takes in preliminary dimensions and design loads
%     - Notes specifications in end conditions 
%     - Specifications of factor of safety
% Sections of the code can be run as necessary to adjust and test different
% parameters


%% Setup: Units and Material database
% Unit system specification
% 'SI' --> Newton-meters and MPa for input/output
% 'Imperial' --> Pound-inch and psi for input/output
Unit_Choice = 'SI';

% Material database read
% Imports the full material data from the specified source csv file
% Reference 'TO_MAE190.csv' for formatting if implementing other files
%    - Refrence readmatrix function for supported file types for reading
%    - Code accesses material from the text name on the left-most column
%    - Properties include: yield and ultiumate strengths
readmatrix("TO_MAE190.csv");


%% Material selection (using chosen material database)
% Refer to materials matlab files for full database used in code
% Material name specification
Mat_n = '1070 steel';


%% Shaft mechanical property specication
% Used in obtaining the properties such as endurance strength that require
% properties such as: finish, size factor, and others
surface_s = 'machined';
reliability_s = 0.95;
temperature_s = 25;     % in Celsius units

% Geometric specifications:
geo_type = 'fillet';
geo_d = 0.1;         % percentage of shaft radius


%% Design load input section
% Mean torsion
Tm = 2;
% Amplitude torsion
Ta = 1;
% Mean moment
Mm = 3;
% Amplitude moment
Ma = 0.5;


%% Factor of safety specification section
% Factor of safety: Capcity/Situation
safety_n = 2;


%% Code/Calculation execution section
% Uses file 'ShaftDiaCal.m' as a function to obtain desired shaft
% dimensions used for design

% Initial guess of diameter for iteration
Ini_d = 0.1;
% Call of the function


