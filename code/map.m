function [n] = map(i,j, nx, ny)
%MAP maps between rectangular and linear cordinates
    global C;
    n = j + (i - 1)*ny;
end

