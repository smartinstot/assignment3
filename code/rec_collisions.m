%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% rec_collisions.m:                          %
% determines if a point is within a rectangle%
% also determines which face that collision  %
% occured on for the purpose of inverting V  %
% collided =                                 %
%               0 --> No collision           %
%               1 --> Collision on X         %
%               2 --> Collision on Y         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [collided] = rec_collisions(P_x, P_y, rec)
    len = size(rec);
    len = len(1);
    collided = zeros(length(P_x),1);
    % Lets loop through all the rectangles
    for i=1:len
        % Just make things have better names
        x = rec(i,1);
        y = rec(i,2);
        w = rec(i,3);
        h = rec(i,4);
        
        % Determine if the point is in the rectangle
        in_x = abs(x + w/2 - P_x) - w/2;
        in_y = abs(y + h/2 - P_y) - h/2;

        loc_collided = (in_x <=0 & in_y <=0 );
        
        % Figure out if it is colliding in horizontal (X) or vertical (Y)
        [~,index] = max([in_x(loc_collided), in_y(loc_collided)], [], 2);
        % Sum up with possible past collisions
        collided(loc_collided) =  index;
    end
end

