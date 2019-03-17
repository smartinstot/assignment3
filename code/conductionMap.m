function cMap = conductionMap(nx, ny, sigma_conduct, sigma_insulate, size_x, size_y, rec)
%CONDUCTIONMAP Generates the map of conductivity of the area for given area
    cMap = sigma_conduct*ones(nx, ny);
    
    n_rec = size(rec);
    n_rec = n_rec(1);
    
    % Calculate the x and y corrdinates of each point in the grid
    P_x = repmat(linspace(0, size_x, nx)', 1, ny);
    P_y = repmat(linspace(0, size_y, ny), nx, 1);

    % Pretty much the same code as the rec_collisions function
    % except it works on a matrix instead of an array
    for n=1:n_rec
        % Just make things have better names
        x = rec(n,1);
        y = rec(n,2);
        w = rec(n,3);
        h = rec(n,4);
        
        % Determine if the point is in the rectangle
        % I need to think a bit more when P_y and P_x are flipped
        in_x = abs(x + w/2 - P_y) - w/2;
        in_y = abs(y + h/2 - P_x) - h/2;

        loc_collided = (in_x <=0 & in_y <=0 );
        cMap(loc_collided) = sigma_insulate;
    end
end

