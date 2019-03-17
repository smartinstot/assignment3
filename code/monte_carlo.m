function [f_e, f_v, f_plot, f_path, f_hist, f_eldn, f_temp, f_i] = monte_carlo(rec, V0)
%MONTE_CARLO Runs the monte carlo simulation under the electric field

    constants;
    
    
    % randomly select the indexes which we are going to plot
    index_plot = randperm(N, N_plot);

    % Inialize State variables
    [P_x, P_y] = inital_placement(N, size_x, size_y, rec);
    [V_x, V_y] = thermal_velocity(N, T, mn);
    
    [E_x, E_y, V] = calculateE(nx, ny, V0, sigma_conduct, sigma_insulate, size_x, size_y, rec);
    
    f_v = figure();
    hold on;
    surf(linspace(0,size_y,ny), linspace(0,size_x,nx), V,'EdgeColor','none','LineStyle','none');
    c = colorbar;
    c.Label.String = 'Potential (V)';
    xlabel('x');
    ylabel('y');
    view([120+180 25]);
    
    f_e = figure();
    hold on;
    [Ex, Ey] = calculateE(nx, ny, V0, sigma_conduct, sigma_insulate, size_x, size_y, rec);
    contourf(linspace(0,size_y,ny), linspace(0,size_x,nx), sqrt(Ex.^2+Ey.^2),'EdgeColor','none','LineStyle','none');
    quiver(linspace(0,size_y,ny), linspace(0,size_x,nx), Ex, Ey);
    c = colorbar;
    c.Label.String = '|E| (V/m)';
    xlabel('x');
    ylabel('y');
    
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
    
    f_i = figure('Name', 'Current');
    hold on;
    title('Current');
    xlabel('Time (s)');
    ylabel('Current (A)');

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
        
        % Calculate the x and y corrdinates of each point in the grid
        Grid_P_x = linspace(0, size_x, nx)';
        Grid_P_y = linspace(0, size_y, ny)';
        
        % Find the index of the closest grid point to each particle
        x_index = findClosest(P_x, Grid_P_x);
        y_index = findClosest(P_y, Grid_P_y);
        
        
        % Convert index points into the electric field experienced by each electron 
        P_E_x = zeros(N, 1);
        P_E_y = zeros(N, 1);
        for i=1:N
            P_E_x = E_x(x_index(i), y_index(i));
            P_E_y = E_y(x_index(i), y_index(i));
        end
        
        % Apply acceleration to the electroncs
        V_x = V_x + (C.q_0.*P_E_x./C.m_0)*dt;
        V_y = V_y + (C.q_0.*P_E_y./C.m_0)*dt;
        
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

        figure(f_i);
        plot(t, (sum(V_x)/N)*C.q_0*C.cd, 'xb');
        %pause(0.01);

        [V_x, V_y, P_x, P_y] = collisions(V_x, V_y, P_x, P_y, size_x, size_y, rec, collision_type, T, mn);
    end

    f_eldn = figure('Name', 'Electron Density');
    n = hist3([P_x, P_y], 'Nbins', [2*ceil(log(N)),2*ceil(log(N))]);
    pcolor(n');
    colorbar;

    f_temp = figure('Name', 'Temperature');
    temperature_map(V_x, V_y, P_x, P_y, size_x, size_y, mn);
end

