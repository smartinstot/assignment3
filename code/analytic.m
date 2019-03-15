function V = analytic(nx, ny, V0, iterations)
%ANALYTIC Calculates the analytic solution for part 1 b, cannot change bc
    V = zeros(nx, ny);
    b = nx;
    a = ny;
    for x = 1:nx
        for y = 1:ny
            for n = 1:2:2*iterations
                V(x,y) = V(x,y) + ((4*V0)/pi)*(1/n)*cosh(n*pi*x/a)/cosh(n*pi*b/a)*sin(n*pi*y/a);
            end
        end
    end
end

