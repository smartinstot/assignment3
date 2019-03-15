function I = sweep(nx, ny, V0, sigma_conduct, sigma_insulate, Wb, Lb)
%SWEEP Calculate the total current for given paramaters
    cMap = conductionMap(nx, ny, sigma_conduct, sigma_insulate, Wb, Lb);
    V = numeric(nx, ny, cMap, Inf, Inf, 0, V0);
    [Ex, Ey] = gradient(V);
    Ex = -Ex;
    Ey = -Ey;
    Jx = cMap.*Ex;
    I = (abs(sum(Jx(1,:))) + abs(sum(Jx(nx,:))))/2;
end

