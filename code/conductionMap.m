function cMap = conductionMap(nx, ny, sigma_conduct, sigma_insulate, Wb, Lb)
%CONDUCTIONMAP Generates the map of conductivity of the area for given area
    cMap = sigma_conduct*ones(nx, ny);
    cMap(1:Wb,(1:Lb)+ny/2-Lb/2) = sigma_insulate;
    cMap((1:Wb)+nx-Wb,(1:Lb)+ny/2-Lb/2) = sigma_insulate;
end

