%% MAE185 HW1
clear all;
clc
load('cylinder_Re100.mat');
% x and y are the coordinates
% u and v are the velocity values
% equidistant and even ime spacings

%% Problem 1.1

% obtaining sizes
%load('cylinder_Re100.mat');
[dt, dx, dy] = size(u);

for ii = 1:dt
hold on
subplot(2,1,1);
hu = pcolor(x,y,squeeze(u(ii,:,:)));
title(['u: Frame ' num2str(ii)]);
set(hu, 'EdgeColor', 'none');
rectangle('Position',[-0.5 -0.5 1 1],'Curvature', ...
    [1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
grid off
subplot(2,1,2);
hv = pcolor(x,y,squeeze(v(ii,:,:)));
title(['v: Frame ' num2str(ii)]);
set(hv, 'EdgeColor', 'none');
rectangle('Position',[-0.5 -0.5 1 1],'Curvature', ...
    [1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
grid off
hold off
drawnow

end

%% Problem 1.2

u_bar = zeros(200,100);
v_bar = zeros(200,100);

for xx = 1:200
    for yy = 1:100
        u_bar(xx,yy) = mean(u(150:end,xx,yy));
        v_bar(xx,yy) = mean(v(150:end,xx,yy));
    end 
end 

subplot(2,1,1);
hu2 = pcolor(x,y,u_bar);
title('Mean of u');
set(hu2, 'EdgeColor', 'none');
axis equal tight
rectangle('Position',[-0.5 -0.5 1 1],'Curvature', ...
    [1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
%caxis([-0.5 2])
colorbar

grid off
subplot(2,1,2);
hv2 = pcolor(x,y,v_bar);
title('Mean of v');
set(hv2, 'EdgeColor', 'none');
axis equal tight
rectangle('Position',[-0.5 -0.5 1 1],'Curvature', ...
    [1 1],'LineStyle','none','FaceColor',[1 1 1]);
xlabel('x')
ylabel('y')
%caxis([-1 1])
colorbar

