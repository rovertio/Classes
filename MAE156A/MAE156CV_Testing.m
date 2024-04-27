%% MAE156 Phone image processing MATLAB test code
% Creates mobile connection to phone via chord and package
% Uses OpenCV integration to mimic future implementation via python

%% Creation of connection with IOS phone
clearvars; % Needs to clear previous camera

m = mobiledev; % Connection with phone
cam = camera(m,'back');

% Camera properties
cam.Resolution = '1280x720';
%cam.Resolution = '720x1280';
cam.Autofocus = 'on';
%cam.Flash = 'off';
%cam.Autofocus = 'on';
cam.Flash = 'on';

%% Aquiring snapshot

% img = snapshot(cam,'manual');
img_test = snapshot(cam,'immediate');
daspect([1,1,1])
image(img_test)

%% Image processing

Gray = rgb2gray(img_test);
Gray=imcrop(Gray,[500,200,520,320]);
BW = imbinarize(Gray, 'adaptive', 'ForegroundPolarity','bright','Sensitivity',0.6);
% figure(1);
% hold on
% imshow(Gray)
% hold off

edge_d="canny";
min_th=0.05;
max_th=0.30;
Gray2=edge(Gray,edge_d,[min_th,max_th]);
BW2=edge(BW,edge_d,[min_th,max_th]);


[g_centers, g_radii, g_metric] = imfindcircles(Gray2,[6 17]);
%[centers, radii, metric] = imfindcircles(BW,[5 30]);

figure(1);
hold on
imshow(Gray2)
viscircles(g_centers, g_radii,'Color','b');
%imshowpair(Gray2,BW2,'montage')
%imshow(BW2)
%viscircles(centers, radii,'Color','b');
hold off


% figure
% imshowpair(Gray,BW,'montage')

%[centers, radii, metric] = imfindcircles(A,[15 30]);

