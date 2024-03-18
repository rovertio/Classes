% UserInput.m --> File made to facilitate shaft design of the user:
%     - Takes in preliminary dimensions and design loads
%     - Notes specifications in end conditions 
%     - Specifications of factor of safety
% Sections of the code can be run as necessary to adjust and test different
% parameters

% Parameters and other values for this script is from the 9th version of
% Shigley's textbook for mechanical design

%% Setup: Units and Material database
% Initialize structure with all input data
sspec = struct;

% Unit system specification
% 'SI' --> Newton-meters and MPa for input/output
% 'Imperial' --> Pound-inch and psi for input/output
sspec.Unit_Choice = 'Imperial';

% Material database read
% Imports the full material data from the specified source csv file
% Reference 'MAE190_MaterialProps - Sheet1.csv' for formatting if 
% implementing other files
%    - Refrence readmatrix function for supported file types for reading
%    - Code accesses material from the text name on the left-most column
%    - Properties include: yield and ultiumate strengths
MatData = readcell("MAE190_MaterialProps - Sheet2.csv");


%% Material selection (using chosen material database)
% Refer to materials matlab files for full database used in code
% Material name specification: 
%   [UNS No.] [SAE/ASI No.] [Processing] [Description (as necessary)]
Mat_n = 'Prob1';

% Extracting maerial properties
sspec.mat_prop = extract_prop(Mat_n,MatData);


%% Shaft mechanical property specication
% NOTE: Percents expressed in decimal form
% NOTE: Temperature in Celsius/Farenheit from specified units
% Used in obtaining the properties such as endurance strength that require
% properties such as: finish, size factor, and others
% Assumes round/circular cross-section
sspec.surface_s = 'machined';
sspec.reliability = 0.9999;
sspec.temperature = 77;    

% Geometry structure initialization
sspec.geo = struct;
% Geometric specifications: fillet and fillet radius
sspec.geo.type = 'fillet';
sspec.geo.lsd = 1.2;          % ratio of large shaft dia to small shaft d
sspec.geo.r = 0.1;            % percentage of smaller shaft diameter


%% Design load input section
% Units: Mega Pascals (SI) & kilo pounds (Imperial)

% Midrange and alternating stress input
% sspec.Tm = 2;           % Mean torsion
% sspec.Ta = 1;           % Amplitude torsion
% sspec.Mm = 3;           % Mean moment
% sspec.Ma = 0.5;         % Amplitude moment


% If the midrange and alternating moment/torque not available:
%   Calculate with minimum and maximum: function midamp
Mmin = 1;
Mmax = 5;
Tmin = 0;
Tmax = 1.8;
% Function for the stress values
[sspec.Ma, sspec.Mm, sspec.Ta, sspec.Tm] = midamp(Mmax, Mmin, Tmax, Tmin);


%% Factor of safety specification section
% Factor of safety: Capcity/Situation
sspec.safety_n = 1.5;

% Failure criteria selection
%sspec.criteria = 'de-gerber';
sspec.criteria = 'goodman';
%sspec.criteria = 'de-asme elliptic';


%% Code/Calculation execution section
% Uses file 'shaft_itt.m' as a function to obtain desired shaft
% dimensions used for design

% Initial guess of diameter for iteration (inches or mm)
Ini_d = 10;
% Convergence criteria: in percent decimal form
ccrit = 0.001;


% Call of the function
[design_dia, iterations, count] = shaft_itt(sspec, Ini_d, ccrit);






%% Supplemental functions

% Material property extraction from csv file
function [mat_prop] = extract_prop(name, database)
mat_prop = struct;
    for i=1:size(database, 1)
        if isequal(name, string(database(i,1)))
            % Accounting for missing data entries: non-strings so from 2nd
            % index start parsing
            props = database(i,2:size(database, 2));
            p_mask = cellfun(@ismissing, props, 'UniformOutput',false);
            props(cell2mat(p_mask)) = {0};

            mat_prop.name = string(database(i,1));
            mat_prop.Sut_SI = cell2mat(props(1));
            mat_prop.Sut_Imperial = cell2mat(props(2));
            mat_prop.Sy_SI = cell2mat(props(3));
            mat_prop.Sy_Imperial = cell2mat(props(4));

            % Notification if values aren't existing
            m_loc = find([p_mask{:}] == 1);
            if ~isequal(m_loc, [])
                p_mess = {'Ultimate Strength (MPa)', ...
                    'Ultimate Stregnth (ksi)', 'Yield Strength (MPa)',...
                    'Yield Strength (ksi)'};
                disp('Properties not available:')
                for k=1:length(m_loc)
                    disp('     - ' + string(p_mess(m_loc(k))))
                end
                disp(['WARNING: Trying to solve with the values above ' ...
                    'under the corresponding unit system will not ' ...
                    'give an answer'])
                disp(['Ensure Unit_Choice matches the available' ...
                    ' property values'])
            end

        end
    end
end 


% Midrange and amplitude calculations
function [Ma, Mm, Ta, Tm] = midamp(Mmax, Mmin, Tmax, Tmin)
    Ma = abs((Mmax - Mmin)/(2));
    Mm = (Mmax + Mmin)/(2);
    Ta = abs((Tmax - Tmin)/(2));
    Tm = (Tmax + Tmin)/(2);
end

