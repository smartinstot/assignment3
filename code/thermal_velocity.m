%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% thermal_velocity.m:                        %
% Calculates the inital velocity of each     %
% particle                                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V_x, V_y] = thermal_velocity(N, T, mn)
    
    kb = physconst('Boltzmann');
    % Calculate the threshold velocity
    vth = sqrt(2*kb*T/mn); 

    % From the threshold velocity, calculate a range of velocities to test
    v_range = linspace(0, vth*4, 1000)';

    % Calculate the velocity pdf at this given temperature
    pdf = 4*pi*(mn/2/pi/kb/T)^1.5 .* v_range.^2 .* exp(-mn*v_range.^2/2/kb/T);
    % Integrate to find the cdf
    cdf = cumtrapz(v_range, pdf);

    % Find the appripriate value at reach point
    V = zeros(N,1);
    for i=1:N
        [c index] = min(abs(cdf - rand));
        V(i) = v_range(index);
    end

    % In order to set the direction, we generate
    % a random number for the x and y directions,
    % normalize, then multiply each velocity by
    % that
    temp_x = 2*rand(N,1) - 1;
    temp_y = 2*rand(N,1) - 1;
    temp = sqrt(temp_x.^2 + temp_y.^2);
    temp_x = temp_x./temp;
    temp_y = temp_y./temp;

    V_x = temp_x .* V;
    V_y = temp_y .* V;
end

