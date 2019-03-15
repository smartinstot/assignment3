%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% Assignment1.m:                             %
% Top level file which runs simulation       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% User Paramaters %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 300; % K, Temperature
m0 = 9.109383E-31; % Kg, rest mass of electron
mn = 0.26*m0; % effective mass of electron
Tmn = 0.2E-12; % s, mean time between collisions

steps = 1000; % Run simulation for 100 steps
dt = 200E-9/1E8; % s, simulation step time

N = 10000; % Number of particles
N_plot = 10; % Number of particles to show in motion plot

% Simulation bounds
size_x = 200E-9; % m
size_y = 200E-9; % m

% Rectangles
%       pos_x       pos_y       width       height
rec = [ 080E-9      000E-9      040E-9      080E-9   ;
        080E-9      120E-9      040E-9      080E-9   ];

collision_type = 0; % 0 = specular, 1 = diffusive

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% End User Paramaters %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculated values
addpath code
vth = sqrt(2*physconst('Boltzmann')*T/mn); % mean thermal velocity
lambda = vth*Tmn; % mean free path
Pscat = 1 - exp(-dt/Tmn);

% randomly select the indexes which we are going to plot
index_plot = randperm(N, N_plot);

tmax = dt*steps; % s, simulation stop time

% Inialize State variables
[P_x, P_y] = inital_placement(N, size_x, size_y, rec);
[V_x, V_y] = thermal_velocity(N, T, mn);

f_path = figure('Name', 'Particle Path');
hold on;
xlim([0 size_x]);
ylim([0 size_y]);

f_plot = figure('Name', 'Simulation Data');

% Plot of average thermal velocity
subplot(3,1,1);
hold on;
title('Average Thermal Velocity');
xlabel('Time (s)');
ylabel('Velocity (m/s)');

% Plot of total energy
subplot(3,1,2);
hold on;
title('Total Energy');
xlabel('Time (s)');
ylabel('Energy (J)');

% Plot of average temperature
subplot(3,1,3);
hold on;
title('Average Temperature');
xlabel('Time (s)');
ylabel('Temperature (C)');

f_hist = figure('Name', 'Velocity');
xlabel('Velocity (m/s)');
ylabel('Number of Particles');

% Simulation loop
for n=0:(steps-1)
    t = n*dt;
    P_x_old = P_x;
    P_y_old = P_y;

    % Scatter 
    temp = Pscat > rand(N,1);
    [V_x(temp), V_y(temp)] = thermal_velocity(sum(temp), T, mn);

    % Laws of motion
    P_x = P_x + V_x*dt;
    P_y = P_y + V_y*dt;
    
    % Plot path of particle
    figure(f_path);
    motion_plot(P_x_old(index_plot), P_x(index_plot), P_y_old(index_plot), P_y(index_plot));
    temp = size(rec);
    for i=1:temp(1)
        rectangle('Position', rec(i,:));
    end

    figure(f_plot);

    subplot(3,1,1);
    plot(t, mean(sqrt(V_x.^2 + V_y.^2)), 'xb');

    subplot(3,1,2);
    plot(t, sum(0.5*(V_x.^2 + V_y.^2)*mn), 'xg');

    subplot(3,1,3);
    plot(t, mean((V_x.^2 + V_y.^2)*mn/2/physconst('Boltzmann')), 'xr');

    figure(f_hist);
    histogram(sqrt(V_x.^2 + V_y.^2), 1000, 'FaceColor', 'b');
    

    %pause(0.01);

    [V_x, V_y, P_x, P_y] = collisions(V_x, V_y, P_x, P_y, size_x, size_y, rec, collision_type, T, mn);
end

f_eldn = figure('Name', 'Electron Density');
n = hist3([P_x, P_y], 'Nbins', [2*ceil(log(N)),2*ceil(log(N))]);
pcolor(n');
colorbar;

f_temp = figure('Name', 'Temperature');
temperature_map(V_x, V_y, P_x, P_y, size_x, size_y, mn);

% Save all plots to image files
saveas(f_plot, 'Simulation_Data.png');
saveas(f_path, 'Particle_Path.png');
saveas(f_hist, 'Velocity.png');
saveas(f_eldn, 'Electron_Density.png');
saveas(f_temp, 'Temperature.png');

close all;
