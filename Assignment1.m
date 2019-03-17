%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% Assignment1.m:                             %
% Top level file which runs simulation       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
addpath code;
constants;

% Geometry
% Rectangles
%       pos_x       pos_y       width       height
rec = [ 080E-9      000E-9      040E-9      080E-9   ;
        080E-9      120E-9      040E-9      080E-9   ];

rec = [];
    
[f_plot, f_path, f_hist, f_eldn, f_temp] = monte_carlo(rec);

close all;
