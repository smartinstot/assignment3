function [Ex, Ey] = calculateE(nx, ny, V0, sigma_conduct, sigma_insulate, size_x, size_y, rec)
%SWEEP Calculate the total current for given paramaters
    cMap = conductionMap(nx, ny, sigma_conduct, sigma_insulate, size_x, size_y, rec);
    V = numeric(nx, ny, cMap, Inf, Inf, 0, V0);
    [Ex, Ey] = gradient(V);
    Ex = -Ex;
    Ey = -Ey;
end

