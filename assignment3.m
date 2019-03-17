%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 3          %
%    Monte-Carlo/Finite Difference Method    %
%            By David Bascelli               %
%            March 17th, 2019                %
% assignment3.m:                             %
% Top level file which runs simulation       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
addpath code;
constants;

%%%%% Part 1 %%%%%

% Geometry
% Rectangles
%       pos_x       pos_y       width       height
rec = [];

    
[f_e1, f_v1, f_plot1, f_path1, f_hist1, f_eldn1, f_temp1] = monte_carlo(rec);
saveas(f_e1, 'Part_1_E.png');
saveas(f_v1, 'Part_1_V.png');
saveas(f_plot1, 'Part_1_Data.png');
saveas(f_path1, 'Part_1_Path.png');
saveas(f_hist1, 'Part_1_Velocity.png');
saveas(f_eldn1, 'Part_1_Density.png');
saveas(f_temp1, 'Part_1_Temperature.png');

%%%%% Part 2 %%%%%

% Geometry
% Rectangles
%       pos_x       pos_y       width       height
rec = [ 080E-9      000E-9      040E-9      080E-9   ;
        080E-9      120E-9      040E-9      080E-9   ];

    
[f_e2, f_v2, f_plot2, f_path2, f_hist2, f_eldn2, f_temp2] = monte_carlo(rec);
saveas(f_e2, 'Part_2_E.png');
saveas(f_v2, 'Part_2_V.png');
saveas(f_plot2, 'Part_2_Data.png');
saveas(f_path2, 'Part_2_Path.png');
saveas(f_hist2, 'Part_2_Velocity.png');
saveas(f_eldn2, 'Part_2_Density.png');
saveas(f_temp2, 'Part_2_Temperature.png');

generateReport(f_e1, f_v1, f_plot1, f_path1, f_hist1, f_eldn1, f_temp1, f_e2, f_v2, f_plot2, f_path2, f_hist2, f_eldn2, f_temp2);

close all;