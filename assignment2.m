%%%%%%%%%%%% ELEC 4700 Assignment - 2 Finite Difference Method %%%%%%%%%%%%
%                           By David Bascelli                             %
%                           Febuary 24th, 2019                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
addpath code;

constants;
f1 = figure();
cMap = conductionMap(nx, ny, sigma_conduct, sigma_insulate, size_x, size_y, rec);
contourf(linspace(0,size_y,ny), linspace(0,size_x,nx), cMap,'EdgeColor','none','LineStyle','none');
shading interp 
xlabel('x');
ylabel('y');
zlabel('Conduction (Mho)');

f2 = figure();
hold on;
[Ex, Ey] = calculateE(nx, ny, V0, sigma_conduct, sigma_insulate, size_x, size_y, rec);
contourf(linspace(0,size_y,ny), linspace(0,size_x,nx), sqrt(Ex.^2+Ey.^2),'EdgeColor','none','LineStyle','none');
quiver(linspace(0,size_y,ny), linspace(0,size_x,nx), Ex, Ey);
c = colorbar;
c.Label.String = '|E| (V/m)';
xlabel('x');
ylabel('y');