
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          ELEC 4700 - Assignment 1          %
% Monte-Carlo Modeling of Electron Transport %
%            By David Bascelli               %
%            Febuary 3rd, 2019               %
% temperature_map.m:                         %
% Calculates the temperature map and plots it%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function temperature_map(V_x, V_y, P_x, P_y, size_x, size_y, mn)
    Nbins = ceil(log(length(V_x)));
    sx = size_x/Nbins;
    sy = size_y/Nbins;
    Temps = zeros(Nbins);
    T = (V_x.^2 + V_y.^2)*mn/2/physconst('Boltzmann');
    for i=0:(Nbins-1)
        for j=0:(Nbins-1)
            sel_x = (P_x > i*sx & P_x < (i+1)*sx);
            sel_y = (P_y > j*sy & P_y < (j+1)*sy);
            temp_T = T(sel_x & sel_y);
            Temps(i+1,j+1) = mean(temp_T);
        end
    end
    contourf(Temps');
    colorbar;
end


