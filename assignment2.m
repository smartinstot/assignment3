%%%%%%%%%%%% ELEC 4700 Assignment - 2 Finite Difference Method %%%%%%%%%%%%
%                           By David Bascelli                             %
%                           Febuary 24th, 2019                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

addpath code;
clear;
global C;
clear;

% Physical constants
C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                    % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458; % speed of light

%%%%% Part 1 - A %%%%%
nx = 75;
V0 = 1; 
V = numeric1D(nx, V0, 0);
f_p1a_numeric = figure();
hold on;
plot(V);
ylabel('Voltage (V)');
xlabel('x');
xlim([0 nx]);

%%%%% Part 1 - B %%%%%
nx = 75;
ny = 50;
V0 = 1; 
cMap = conductionMap(nx, ny, 1, 1E-2, 0, 0);

V_numeric = numeric(nx, ny, cMap, V0, V0, 0, 0);
V_analytic = analytic(nx, ny, V0, 50);

% Numeric plot
f_p1b_numeric = figure();
hold on;
surf(linspace(0,1.5,ny), linspace(0,1,nx), V_numeric,'EdgeColor','none','LineStyle','none');
shading interp 
xlabel('x');
ylabel('y');
zlabel('Voltage (V)');
view([120 25]);

% Analytic plot
f_p1b_analytic = figure();
hold on;
surf(linspace(0,1.5,ny), linspace(0,1,nx), V_analytic,'EdgeColor','none','LineStyle','none');
shading interp 
xlabel('x');
ylabel('y');
zlabel('Voltage (V)');
view([120 25]);

%%%%% Part 2 - A %%%%%
nx = 75;
ny = 50;
V0 = 1; 
f_p2a_cMap = figure();
hold on;
cMap = conductionMap(nx, ny, 1, 1E-2, 20, 10);
surf(linspace(0,1.5,ny), linspace(0,1,nx), cMap,'EdgeColor','none','LineStyle','none');
shading interp 
xlabel('x');
ylabel('y');
zlabel('Conduction (Mho)');
view([120 25]);

V = numeric(nx, ny, cMap, Inf, Inf, 0, V0);

% Numeric solution
f_p2a_V = figure();
hold on;
surf(linspace(0,1.5,ny), linspace(0,1,nx), V,'EdgeColor','none','LineStyle','none');
shading interp 
xlabel('x');
ylabel('y');
zlabel('Voltage (V)');
view([120 25]);

% Find electric field
[Ex, Ey] = gradient(V);
Ex = -Ex;
Ey = -Ey;
f_p2a_E = figure();
quiver(linspace(0,1.5,ny), linspace(0,1,nx), Ex, Ey);
ylim([0 1]);
xlim([0 1.5]);
xlabel('x');
ylabel('y');

% Find current density
Jx = cMap.*Ex;
Jy = cMap.*Ey;
J = sqrt(Jx.^2 + Jy.^2);
f_p2a_J = figure();
hold on;
contourf(linspace(0,1.5,ny), linspace(0,1,nx), J,'EdgeColor','none','LineStyle','none');
quiver(linspace(0,1.5,ny), linspace(0,1,nx), Jx, Jy);
c = colorbar;
c.Label.String = 'Current Density (Amps per Area)';
xlabel('x');
ylabel('y');

%%%%% Part 2 - B %%%%%
f_p2b = figure();
hold on;
V0 = 1;
sigma_conduct = 1;
sigma_insulate = 1E-2;
Wb = 20;
Lb = 10;
nx = 75;
ny = 50;
range = 20:5:100;
I = [];
for x = range
    I = [I sweep(x, ny, V0, sigma_conduct, sigma_insulate, Wb, Lb)];
end
plot(range, I);
ylabel('Total Current (A)');
xlabel('Width mesh size');

%%%%% Part 2 - C %%%%%
f_p2c = figure();
hold on;
V0 = 1;
sigma_conduct = 1;
sigma_insulate = 1E-2;
Wb = 20;
Lb = 10;
nx = 75;
ny = 50;
range = 0:1:50;
I = [];
for W = range
    I = [I sweep(nx, ny, V0, sigma_conduct, sigma_insulate, W, Lb)];
end
plot(range, I);
ylabel('Total Current (A)');
xlabel('Box width');

%%%%% Part 2 - D %%%%%
f_p2d = figure();
hold on;
V0 = 1;
sigma_conduct = 1;
sigma_insulate = 1E-2;
Wb = 20;
Lb = 10;
nx = 75;
ny = 50;
range = logspace(-5,0, 50);
I = [];
for sigma = range
    I = [I sweep(nx, ny, V0, sigma_conduct, sigma, Wb, Lb)];
end
plot(range, I);
ylabel('Total Current (A)');
xlabel('Box Conduction (Mho)');


generateReport(f_p1a_numeric, f_p1b_numeric, f_p1b_analytic, f_p2a_cMap, f_p2a_V, f_p2a_E, f_p2a_J, f_p2b, f_p2c, f_p2d);
close(f_p1a_numeric);
close(f_p1b_numeric);
close(f_p1b_analytic);
close(f_p2a_cMap);
close(f_p2a_V);
close(f_p2a_E);
close(f_p2a_J);
close(f_p2b);
close(f_p2c);
close(f_p2d);
