%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% initial_plaacement.m:                      %
% This file determines the inital placement  %
% of all particles in system                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [P_x, P_y] = inital_placement(N, size_x, size_y, rec)
    P_x = rand(N, 1) * size_x;
    P_y = rand(N, 1) * size_y;
    % Keep looping till none of the points are in the rectangles
    while (1)
        % Find where the collisions are
        collided = rec_collisions(P_x, P_y, rec) ~= 0;
        if (sum(collided) == 0)
            break;
        end
        % Re-roll the locations for the points in the rectangle
        P_x(collided) = rand(sum(collided),1) * size_x;
        P_y(collided) = rand(sum(collided),1) * size_y;
    end
end

