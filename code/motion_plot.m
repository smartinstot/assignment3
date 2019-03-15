%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% motion_plot.m:                             %
% Plots the particle paths                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function motion_plot(P_x_old, P_x, P_y_old, P_y)
    colours = 'gbkymcr'; 
    for i = 1:length(P_x)
        plot([P_x_old(i) P_x(i)], [P_y_old(i) P_y(i)], colours(mod(i, length(colours))+1));
    end
end
