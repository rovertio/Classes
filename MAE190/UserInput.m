% UserInput.m --> File made to facilitate shaft design of the user:
%     - Takes in preliminary dimensions and design loads
%     - Notes specifications in end conditions 
%     - Specifications of factor of safety
% Sections of the code can be run as necessary to adjust and test different
% parameters


%% Setup: Units and Material database
% Initialize structure with all input data
sspec = struct;

% Unit system specification
% 'SI' --> Newton-meters and MPa for input/output
% 'Imperial' --> Pound-inch and psi for input/output
sspec.Unit_Choice = 'SI';

% Material database read
% Imports the full material data from the specified source csv file
% Reference 'TO_MAE190.csv' for formatting if implementing other files
%    - Refrence readmatrix function for supported file types for reading
%    - Code accesses material from the text name on the left-most column
%    - Properties include: yield and ultiumate strengths
MatData = readmatrix("TO_MAE190.csv");


%% Material selection (using chosen material database)
% Refer to materials matlab files for full database used in code
% Material name specification
Mat_n = '1070 steel';

% Extracting maerial properties
sspec.mat_prop = extract_prop(Mat_n,MatData);

%% Shaft mechanical property specication
% Used in obtaining the properties such as endurance strength that require
% properties such as: finish, size factor, and others
% Assumes round/circular cross-section
sspec.surface_s = 'machined';
sspec.reliability = 0.95;
sspec.temperature = 25;     % in Celsius/Farenheit from specified units

% Geometry structure initialization
geo = struct;
sspec.geo = geo;
% Geometric specifications: fillet and fillet radius
geo.type = 'fillet';
geo.lsd = 1.2;          % large shaft dia as percentage of small shaft d
geo.r = 0.1;            % percentage of smaller shaft diameter


%% Design load input section
% Mean torsion
sspec.Tm = 2;
% Amplitude torsion
sspec.Ta = 1;
% Mean moment
sspec.Mm = 3;
% Amplitude moment
sspec.Ma = 0.5;


%% Factor of safety specification section
% Factor of safety: Capcity/Situation
sspec.safety_n = 2;

% Failure criteria selection
sspec.criteria = 'goodman';


%% Code/Calculation execution section
% Uses file 'ShaftDiaCal.m' as a function to obtain desired shaft
% dimensions used for design

% Initial guess of diameter for iteration
Ini_d = 0.1;
% Convergence criteria: in percent
ccrit = 0.5;


% Call of the function
design_dia = shaft_itt(sspec, Ini_d, ccrit)


%% Material property extraction function

function [mat_prop] = extract_prop(name, database)
mat_prop = struct;
    for i=1:length(database, 1)
        if isequal(name, database(i,1))
            mat_prop.name = database(i,1);
            mat_prop.Sy = database(i,2);
            mat_prop.Sut = database(i,3);
        end
    end
end 


